import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_chatgpt/db/favorite_dao.dart';
import 'package:flutter_chatgpt/db/xy_db_manager.dart';
import 'package:flutter_chatgpt/models/favorite_model.dart';
import 'package:flutter_chatgpt/stores/wonderful_store.dart';
import 'package:flutter_chatgpt/utils/xy_dialog.dart';
import 'package:flutter_chatgpt/utils/xy_utils.dart';
import 'package:get/get.dart';

class WonderfulController extends GetxController {
  late FavoriteDao favoriteDao;

  final WonderfulStore wonderfulStore = Get.find<WonderfulStore>();
  RxList<FavoriteModel> get favoriteList => wonderfulStore.favoriteList;

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
    XYDialog.closeAllSnackBar();
    super.onClose();
  }

  void _doInit() async {
    var dbManager =
        await XYDBManager.instance(dbName: XYDBManager.getAccountHash());
    favoriteDao = FavoriteDao(dbManager);
    _loadData();
  }

  void _loadData() async {
    var list = await favoriteDao.getFavoriteList();
    wonderfulStore.favoriteList.assignAll(list);
  }

  void onLongPress(FavoriteModel model, BuildContext ancestor) {
    XYDialog.showPopMenu(ancestor, items: [
      PopupMenuItem(
        onTap: () => XYUtils.copyMessage(model.content),
        child: const Text("复制"),
      ),
      PopupMenuItem(
        onTap: () => _onDelete(model),
        child: const Text("删除"),
      ),
      PopupMenuItem(
        onTap: () => XYDialog.showSnackBar(message: "敬请期待"),
        child: const Text("转发"),
      ),
      PopupMenuItem(
        onTap: () => XYDialog.showSnackBar(message: "敬请期待"),
        child: const Text("更多"),
      ),
    ]);
  }

  void jumpToDetail(FavoriteModel model, BuildContext ancestor) {
    Get.toNamed("message_detail", arguments: {
      "favoriteModel": model,
    });
  }

  _onDelete(FavoriteModel model) async {
    var result = await favoriteDao.removeFavorite(model);
    var showText = "";
    if (result != null && result > 0) {
      wonderfulStore.favoriteList.remove(model);
      showText = "删除成功";
    } else {
      showText = "删除失败";
    }
    XYDialog.showSnackBar(message: showText);
  }
}
