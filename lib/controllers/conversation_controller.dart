import 'dart:convert';

import 'package:chat_message/core/chat_controller.dart';
import 'package:chat_message/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chatgpt/dao/completion_dao.dart';
import 'package:flutter_chatgpt/db/favorite_dao.dart';
import 'package:flutter_chatgpt/db/xy_db_manager.dart';
import 'package:flutter_chatgpt/models/favorite_model.dart';
import 'package:flutter_chatgpt/utils/xy_dialog.dart';
import 'package:flutter_chatgpt/utils/xy_utils.dart';
import 'package:get/get.dart';
import 'package:login_sdk/dao/login_dao.dart';
import 'package:openai_flutter/utils/ai_logger.dart';

import '../db/message_dao.dart';
import '../models/conversation_model.dart';
import '../pages/conversation_page.dart';

class ConversationController extends GetxController {
  late final ConversationModel conversationModel;
  late OnConversationUpdate? conversationUpdate;

// 若为新建的对话框，则_pendingUpdate为true
  bool get _pendingUpdate => conversationModel.title == null;

  // 是否有通知聊天列表页更新当前会话
  bool _hadUpdate = false;

  String inputMessage = "";

  final _sendBtnEnable = true.obs;

  get sendBtnEnable => _sendBtnEnable.value;

  set sendBtnEnable(val) => _sendBtnEnable.value = val;

  late ChatController chatController;
  late MessageDao messageDao;
  late FavoriteDao favoriteDao;
  late CompletionDao completionDao;
  late Map<String, dynamic> userInfo;
  final ScrollController _scrollController = ScrollController();

  String get title => sendBtnEnable ? "与xy的会话" : "对方正在输入...";

  @override
  void onInit() {
    _doInit();
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    _updateConversation();
    super.onClose();
  }

  void _doInit() async {
    conversationModel = Get.arguments["conversationModel"];
    conversationUpdate = Get.arguments["conversationUpdate"];
    userInfo = LoginDao.getUserInfo()!;
    chatController = ChatController(
      initialMessageList: [],
      scrollController: _scrollController,
      timePellet: 60,
    );

    // 下拉出发加载更多
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _loadData(loadMore: true);
      }
    });

    var dbManager = await XYDBManager.instance(dbName: XYDBManager.getAccountHash());
    messageDao = MessageDao(dbManager, cid: conversationModel.cid);
    favoriteDao = FavoriteDao(dbManager);
    var list = await _loadData();
    chatController.loadMoreData(list);
    completionDao = CompletionDao(messages: list);
  }

  int pageIndex = 1;

  // 从数据库中加载历史聊天记录
  Future<List<MessageModel>> _loadData({loadMore = false}) async {
    if (loadMore) {
      pageIndex++;
    } else {
      pageIndex = 1;
    }
    var list = await messageDao.getMessages(pageIndex: pageIndex);
    AILogger.log("count:${list.length}");
    AILogger.log(jsonEncode(list));
    if (loadMore) {
      if (list.isNotEmpty) {
        chatController.loadMoreData(list);
      } else {
        // 如果没有更多的数据，则pageIndex不增加
        pageIndex--;
      }
    }
    return list;
  }

  // 不用inputMessage是因为在结果回来之前, iputMessage可能会变
  void onSend(final String inputMessage) async {
    conversationModel.hadChanged = true;
    _addMessage(_genMessageModel(ownerType: OwnerType.sender, message: inputMessage));
    sendBtnEnable = false;
    String? response = "";
    try {
      response = await completionDao.createCompletions(prompt: inputMessage);
      response = response?.replaceFirst("\n\n", "");
      AILogger.log(response);
    } catch (e) {
      response = e.toString();
      AILogger.log(e.toString());
    }
    response ??= "no response";
    _addMessage(_genMessageModel(ownerType: OwnerType.receiver, message: response));
    sendBtnEnable = true;
    update();
  }

  // 通知聊天列表更新当前会话
  _notifyConversationListUpdate() {
    if (!_hadUpdate && _pendingUpdate && conversationUpdate != null) {
      _hadUpdate = true;
      _updateConversation();
      conversationUpdate!(conversationModel);
    }
  }

  MessageModel _genMessageModel({required OwnerType ownerType, required String message}) {
    String avatar, ownerName;
    if (ownerType == OwnerType.sender) {
      avatar = userInfo["avatar"];
      ownerName = userInfo["userName"];
    } else {
      avatar = "https://o.devio.org/images/o_as/avatar/tx2.jpeg";
      ownerName = "xiaoyang";
    }
    return MessageModel(
        ownerType: ownerType,
        content: message,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        avatar: avatar,
        ownerName: ownerName);
  }

  void _addMessage(MessageModel model) {
    chatController.addMessage(model);
    messageDao.saveMessage(model);
    _notifyConversationListUpdate();
  }

  void _updateConversation() {
    // 更新会话信息
    if (chatController.initialMessageList.isNotEmpty) {
      var model = chatController.initialMessageList.first;
      conversationModel.lastMessage = model.content;
      conversationModel.updatedAt = model.createdAt;
      conversationModel.title = chatController.initialMessageList.last.content;
    }
  }

  void onBubbleLongPress(MessageModel message, BuildContext ancestor) {
    bool left = message.ownerType == OwnerType.receiver;
    double offsetX = left ? -100 : 50;
    XYDialog.showPopMenu(ancestor, offsetX: offsetX, items: [
      PopupMenuItem(
        child: const Text("设为精彩"),
        onTap: () {
          _addFavorite(message);
        },
      ),
      PopupMenuItem(
        child: const Text("复制"),
        onTap: () {
          _copyMessage(message);
        },
      ),
      PopupMenuItem(
        child: const Text("删除"),
        onTap: () {
          _deleteMessage(message);
        },
      ),
      PopupMenuItem(
        child: const Text("转发"),
        onTap: () {
          // TODO:
        },
      ),
    ]);
  }

  void _addFavorite(MessageModel message) async {
    var result = await favoriteDao.addFavorite(FavoriteModel(
      content: message.content,
      createdAt: message.createdAt,
      ownerName: message.ownerName,
    ));
    var showText = "";
    if (result != null && result > 0) {
      showText = "收藏成功";
    } else {
      showText = "收藏失败";
    }
    XYDialog.showSnackBar(message: showText);
  }

  void _copyMessage(MessageModel message)  {
    XYUtils.copyMessage(message.content);
  }

  void _deleteMessage(MessageModel message) {
    // TODO:
  }
}
