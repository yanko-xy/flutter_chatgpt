import 'package:flutter/material.dart';
import 'package:flutter/src/gestures/tap.dart';
import 'package:flutter_chatgpt/models/favorite_model.dart';
import 'package:flutter_chatgpt/utils/xy_utils.dart';
import 'package:get/get.dart';

class MessageDetailController extends GetxController {
  final Rx<FavoriteModel> _model = Rx(Get.arguments["favoriteModel"]);

  FavoriteModel get model => _model.value;

  set model(val) => _model.value = val;

  TapDownDetails? details;

  @override
  void onInit() {
    super.onInit();
  }

  void onLongPress(BuildContext context) {
    // 根据点击位置计算出弹窗的位置
    var offsetY = details?.localPosition.dy ?? 0;
    var offsetX = details?.localPosition.dx ?? 0;
    final RelativeRect position =
        RelativeRect.fromLTRB(offsetX, offsetY + 140, offsetX, 0);
    showMenu(context: context, position: position, items: [
      PopupMenuItem(
        child: const Text("复制"),
        onTap: () => XYUtils.copyMessage(model.content),
      )
    ]);
  }

  onTapDown(TapDownDetails details) {
    this.details = details;
  }
}
