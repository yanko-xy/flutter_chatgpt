import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/utils/xy_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class ThemeConfig extends GetxController {
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

  static ThemeData? _theme;
  static String? _themeMode;

  // 获取主题模型
  static ThemeData getThemeData(String? theme) {
    ThemeData themeData;
    switch (theme) {
      case 'blue':
        themeData = ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true);
        break;
      case 'red':
        themeData = ThemeData(colorSchemeSeed: Colors.red, useMaterial3: true);
        break;
      case 'deepPurple':
        themeData = ThemeData(colorSchemeSeed: Colors.deepPurple, useMaterial3: true);
        break;
      case 'indigo':
        themeData = ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true);
        break;
      case 'lightBlue':
        themeData = ThemeData(colorSchemeSeed: Colors.lightBlue, useMaterial3: true);
        break;
      case 'cyan':
        themeData = ThemeData(colorSchemeSeed: Colors.cyan, useMaterial3: true);
        break;
      case 'teal':
        themeData = ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true);
        break;
      case 'purple':
        themeData = ThemeData(colorSchemeSeed: Colors.purple, useMaterial3: true);
        break;
      case 'green':
        themeData = ThemeData(colorSchemeSeed: Colors.green, useMaterial3: true);
        break;
      case 'lightGreen':
        themeData = ThemeData(colorSchemeSeed: Colors.lightGreen, useMaterial3: true);
        break;
      case 'lime':
        themeData = ThemeData(colorSchemeSeed: Colors.lime, useMaterial3: true);
        break;
      case 'yellow':
        themeData = ThemeData(colorSchemeSeed: Colors.yellow, useMaterial3: true);
        break;
      case 'amber':
        themeData = ThemeData(colorSchemeSeed: Colors.amber, useMaterial3: true);
        break;
      case 'orange':
        themeData = ThemeData(colorSchemeSeed: Colors.orange, useMaterial3: true);
        break;
      case 'deepOrange':
        themeData = ThemeData(colorSchemeSeed: Colors.deepOrange, useMaterial3: true);
        break;
      case 'brown':
        themeData = ThemeData(colorSchemeSeed: Colors.brown, useMaterial3: true);
        break;
      case 'grey':
        themeData = ThemeData(colorSchemeSeed: Colors.grey, useMaterial3: true);
        break;
      case 'pink':
        themeData = ThemeData(colorSchemeSeed: Colors.pink, useMaterial3: true);
        break;
      default:
        themeData = ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true);
        break;
    }
    return themeData;
  }

  Future<ThemeData> init() async {
    String? theme = await XYStoreage.read(key: keyThemeColor);
    _theme = getThemeData(theme ?? "blue");
    _themeMode = theme ?? "blue";
    return _theme!;
  }

  // 改变主题
  static void changeTheme({required String themeMode}) async {
    await XYStoreage.write(key: keyThemeColor, value: themeMode);
    _theme = getThemeData(themeMode);
    _themeMode = themeMode;

    Get.changeTheme(_theme!);

    Future.delayed(const Duration(milliseconds: 300), () {
      Get.forceAppUpdate();
    });
  }

  static String getThemeMode() {
    return _themeMode!;
  }

  // 获取主题
  Future<ThemeData> getTheme() async {
    _theme ??= (await init());
    debugPrint(_theme.toString());
    return _theme!;
  }
}
