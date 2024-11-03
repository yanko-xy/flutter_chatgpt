
import 'package:flutter/services.dart';
import 'package:flutter_chatgpt/utils/xy_dialog.dart';

class XYUtils {
  static void copyMessage(String message) {
    Clipboard.setData(ClipboardData(text: message));
    XYDialog.showSnackBar(message: "复制成功");
  }
}
