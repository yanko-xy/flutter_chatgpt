import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class ThemeConfig extends GetxController {
  final themeStorage = const FlutterSecureStorage();
  static const keyThemeColor = "theme_color";
  static const themes = [
    "blue",
    "red",
    "pink",
    "purple",
    "deepPurple",
    "indigo",
    "cyan",
    "teal",
    "green",
    "lightGreen",
    "lime",
    "yellow",
    "amber",
    "orange",
    "deepOrange",
    "brown",
    "grey",
  ];

  MaterialColor? _themeColor;

  // 获取主题模型
  static MaterialColor getThemeColor(String? theme) {
    MaterialColor color;
    switch (theme) {
      case 'blue':
        color = Colors.blue;
        break;
      case 'red':
        color = Colors.red;
        break;
      case 'deepPurple':
        color = Colors.deepPurple;
        break;
      case 'indigo':
        color = Colors.indigo;
        break;
      case 'lightBlue':
        color = Colors.lightBlue;
        break;
      case 'cyan':
        color = Colors.cyan;
        break;
      case 'teal':
        color = Colors.teal;
        break;
      case 'purple':
        color = Colors.purple;
        break;
      case 'green':
        color = Colors.green;
        break;
      case 'lightGreen':
        color = Colors.lightGreen;
        break;
      case 'lime':
        color = Colors.lime;
        break;
      case 'yellow':
        color = Colors.yellow;
        break;
      case 'amber':
        color = Colors.amber;
        break;
      case 'orange':
        color = Colors.orange;
        break;
      case 'deepOrange':
        color = Colors.deepOrange;
        break;
      case 'brown':
        color = Colors.brown;
        break;
      case 'grey':
        color = Colors.grey;
        break;
      case 'pink':
        color = Colors.pink;
        break;
      default:
        color = Colors.blue;
        break;
    }
    return color;
  }

  Future<MaterialColor> init() async {
    String? theme = await themeStorage.read(key: keyThemeColor);
    return getThemeColor(theme ?? "pink");
  }

  // 设置主题
  void setTheme({required String colorName}) {
    themeStorage.write(key: keyThemeColor, value: colorName);
    _themeColor = getThemeColor(colorName);
  }

  // 获取主题
  Future<ThemeData> getTheme() async {
    _themeColor ??= (await init());
    debugPrint(_themeColor.toString());
    return ThemeData(colorSchemeSeed: _themeColor, useMaterial3: true);
  }
}
