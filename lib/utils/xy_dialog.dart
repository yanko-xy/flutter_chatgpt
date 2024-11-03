import 'package:flutter/material.dart';
import 'package:get/get.dart';

class XYDialog {
  XYDialog._();

  // 在context所属的widget下方弹出menu； offsetX、offsetY为水平和垂直方向的偏移量；items为弹出的菜单项
  static Future<T?> showPopMenu<T>(BuildContext context,
      {required List<PopupMenuEntry<T>> items, double offsetX = 0, offsetY = 0}) {
    var x = MediaQuery.of(context).size.width / 2 + offsetX;
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    var y = offset.dy + renderBox.size.height + offsetY;
    // 计算弹框展示的位置
    final RelativeRect position = RelativeRect.fromLTRB(x, y, x, 0);
    return showMenu(context: context, position: position, items: items);
  }

  static showSnackBar({String title = "提示", String? message}) {
    Get.snackbar(title, message ?? "");
  }

  static closeAllSnackBar() {
    Get.closeAllSnackbars();
  }
}
