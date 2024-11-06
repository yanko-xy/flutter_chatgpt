import 'dart:convert';

import 'package:flutter_chatgpt/db/conversation_dao.dart';
import 'package:flutter_chatgpt/db/message_dao.dart';
import 'package:flutter_chatgpt/db/xy_db_manager.dart';
import 'package:flutter_chatgpt/models/conversation_model.dart';
import 'package:flutter_chatgpt/widgets/conversation_widget.dart';
import 'package:get/get.dart';
import 'package:openai_flutter/utils/ai_logger.dart';

class ConversationListController extends GetxController {
  RxList<ConversationModel> conversationList = RxList([]);

  RxList<ConversationModel> stickConversationList = RxList([]);
  late ConversationListDao conversationListDao;

  // 跳转到对话详情期待更新的model
  Rx<ConversationModel>? pendingModel;

  get dataCount => conversationList.length + stickConversationList.length;

  @override
  void onInit() {
    _doInit();
    super.onInit();
  }

  conversationWidget(int pos) {
    ConversationModel model;
    if (pos < stickConversationList.length) {
      model = stickConversationList[pos];
    } else {
      model = conversationList[pos - stickConversationList.length];
    }

    return ConversationWidget(
      model: model,
      onPressed: _jumpToConversation,
      onDelete: _doDelete,
      onStick: _onStick,
    );
  }

  // 创建新的会话
  void createConversation() {
    int cid = DateTime.now().millisecondsSinceEpoch;
    _jumpToConversation(
        ConversationModel(cid: cid, icon: "https://o.devio.org/images/o_as/avatar/tx5.jpeg"));
  }

  void _doInit() async {
    var storage = await XYDBManager.instance(dbName: XYDBManager.getAccountHash());
    conversationListDao = ConversationListDao(storage);
    _loadStickData();
    _loadData();
  }

  Future<List<ConversationModel>> _loadStickData({loadMore = false}) async {
    var list = await conversationListDao.getStickConversationList();
    stickConversationList = RxList(list);
    update();
    return list;
  }

  int pageIndex = 1;

  Future<List<ConversationModel>> _loadData({loadMore = false}) async {
    if (loadMore) {
      pageIndex += 1;
    } else {
      pageIndex = 1;
    }
    var list = await conversationListDao.getConversationList(pageIndex: pageIndex);
    AILogger.log("count:${list.length}");
    AILogger.log(jsonEncode(list));
    if (loadMore) {
      conversationList.addAll(list);
    } else {
      conversationList.assignAll(list);
    }

    return list;
  }

  void _jumpToConversation(ConversationModel model) {
    pendingModel = model.obs;
    Get.toNamed("conversation", arguments: {
      "conversationModel": model,
      "conversationUpdate": (model) => _doUpdate(model.cid),
    })?.then((value) => {
          // 从对话详情也返回
          Future.delayed(const Duration(milliseconds: 500), () => _doUpdate(model.cid))
        });
  }

  _doUpdate(int cid) async {
    // fix: 新建会话，没有聊天消息也会保存的问题

    if (pendingModel == null || pendingModel?.value?.title == null) return;
    var messageDao = MessageDao(conversationListDao.storage, cid: cid);
    var count = await messageDao.getMessageCount();
    // fix: 置顶消息从会话框返回重复添加的问题
    if (pendingModel!.value!.stickTime > 0) {
      if (!stickConversationList.contains(pendingModel!.value)) {
        stickConversationList.add(pendingModel!.value!);
      } else {
        stickConversationList[stickConversationList.indexOf(pendingModel!.value)] =
            pendingModel!.value;
      }
    } else {
      if (!conversationList.contains(pendingModel!.value)) {
        conversationList.add(pendingModel!.value!);
      } else {
        conversationList[conversationList.indexOf(pendingModel!.value)] = pendingModel!.value;
      }
    }

    // 触发刷新
    pendingModel!.update((value) {
      value?.messageCount = count;
    });

    AILogger.log(pendingModel!.value!.messageCount.toString());
    conversationListDao.saveConversation(pendingModel!.value!);
  }

  _doDelete(ConversationModel model) {
    conversationListDao.deleteConversation(model);
    conversationList.remove(model);
    stickConversationList.remove(model);
    update();
  }

  _onStick(ConversationModel model, {required bool isStick}) async {
    var result = await conversationListDao.updatgeStickTime(model, isStick: isStick);
    // 操作失败
    if (result <= 0) {
      return;
    }
    if (isStick) {
      // 从之前的列表中移除
      conversationList.remove(model);
      if (!stickConversationList.contains(model)) {
        stickConversationList.insert(0, model);
      }
    } else {
      stickConversationList.remove(model);
      if (!conversationList.contains(model)) {
        conversationList.insert(0, model);
      }
    }
  }
}
