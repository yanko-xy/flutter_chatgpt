import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/theme/app_colors_theme.dart';
import 'package:flutter_chatgpt/theme/app_dimensions_theme.dart';
import 'package:flutter_chatgpt/theme/app_texts_theme.dart';
import 'package:flutter_chatgpt/theme/app_theme_mode.dart';
import 'package:flutter_chatgpt/utils/xy_storage.dart';
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
  static AppThemeMode? _themeMode;
  static BuildContext? _context;

  static String getThemeName(AppThemeMode? theme) {
    switch (theme) {
      case AppThemeMode.light:
        return "light";
      case AppThemeMode.dark:
        return "dark";
      case AppThemeMode.system:
        return "system";
      case AppThemeMode.blue:
        return "blue";
      case AppThemeMode.red:
        return "red";
      case AppThemeMode.deepPurple:
        return "deepPurple";
      case AppThemeMode.indigo:
        return "indigo";
      case AppThemeMode.lightBlue:
        return "lightBlue";
      case AppThemeMode.cyan:
        return "cyan";
      case AppThemeMode.teal:
        return "teal";
      case AppThemeMode.purple:
        return "purple";
      case AppThemeMode.green:
        return "green";
      case AppThemeMode.lightGreen:
        return "lightGreen";
      case AppThemeMode.lime:
        return "lime";
      case AppThemeMode.yellow:
        return "yellow";
      case AppThemeMode.amber:
        return "amber";
      case AppThemeMode.orange:
        return "orange";
      case AppThemeMode.deepOrange:
        return "deepOrange";
      case AppThemeMode.brown:
        return "brown";
      case AppThemeMode.grey:
        return "grey";
      case AppThemeMode.pink:
        return "pink";
      default:
        return "light";
    }
  }

  static AppThemeMode getThemeMode(String? themeName) {
    switch (themeName) {
      case "light":
        return AppThemeMode.light;
      case "dark":
        return AppThemeMode.dark;
      case "system":
        return AppThemeMode.system;
      case "blue":
        return AppThemeMode.blue;
      case "red":
        return AppThemeMode.red;
      case "deepPurple":
        return AppThemeMode.deepPurple;
      case "indigo":
        return AppThemeMode.indigo;
      case "lightBlue":
        return AppThemeMode.lightBlue;
      case "cyan":
        return AppThemeMode.cyan;
      case "teal":
        return AppThemeMode.teal;
      case "purple":
        return AppThemeMode.purple;
      case "green":
        return AppThemeMode.green;
      case "lightGreen":
        return AppThemeMode.lightGreen;
      case "lime":
        return AppThemeMode.lime;
      case "yellow":
        return AppThemeMode.yellow;
      case "amber":
        return AppThemeMode.amber;
      case "orange":
        return AppThemeMode.orange;
      case "deepOrange":
        return AppThemeMode.deepOrange;
      case "brown":
        return AppThemeMode.brown;
      case "grey":
        return AppThemeMode.grey;
      case "pink":
        return AppThemeMode.pink;
      default:
        return AppThemeMode.light;
    }
  }

  // 获取主题模型
  static ThemeData getThemeData(AppThemeMode? theme) {
    ThemeData themeData;
    switch (theme) {
      case AppThemeMode.light:
        themeData = ThemeData.from(
            colorScheme:
                ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.light));
        break;
      case AppThemeMode.dark:
        themeData = ThemeData.from(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.dark));
        break;
      case AppThemeMode.system:
        themeData = ThemeData.from(
            colorScheme:
                ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.light));
        break;
      case AppThemeMode.blue:
        themeData = ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true);
        break;
      case AppThemeMode.red:
        themeData = ThemeData(colorSchemeSeed: Colors.red, useMaterial3: true);
        break;
      case AppThemeMode.deepPurple:
        themeData = ThemeData(colorSchemeSeed: Colors.deepPurple, useMaterial3: true);
        break;
      case AppThemeMode.indigo:
        themeData = ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true);
        break;
      case AppThemeMode.lightBlue:
        themeData = ThemeData(colorSchemeSeed: Colors.lightBlue, useMaterial3: true);
        break;
      case AppThemeMode.cyan:
        themeData = ThemeData(colorSchemeSeed: Colors.cyan, useMaterial3: true);
        break;
      case AppThemeMode.teal:
        themeData = ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true);
        break;
      case AppThemeMode.purple:
        themeData = ThemeData(colorSchemeSeed: Colors.purple, useMaterial3: true);
        break;
      case AppThemeMode.green:
        themeData = ThemeData(colorSchemeSeed: Colors.green, useMaterial3: true);
        break;
      case AppThemeMode.lightGreen:
        themeData = ThemeData(colorSchemeSeed: Colors.lightGreen, useMaterial3: true);
        break;
      case AppThemeMode.lime:
        themeData = ThemeData(colorSchemeSeed: Colors.lime, useMaterial3: true);
        break;
      case AppThemeMode.yellow:
        themeData = ThemeData(colorSchemeSeed: Colors.yellow, useMaterial3: true);
        break;
      case AppThemeMode.amber:
        themeData = ThemeData(colorSchemeSeed: Colors.amber, useMaterial3: true);
        break;
      case AppThemeMode.orange:
        themeData = ThemeData(colorSchemeSeed: Colors.orange, useMaterial3: true);
        break;
      case AppThemeMode.deepOrange:
        themeData = ThemeData(colorSchemeSeed: Colors.deepOrange, useMaterial3: true);
        break;
      case AppThemeMode.brown:
        themeData = ThemeData(colorSchemeSeed: Colors.brown, useMaterial3: true);
        break;
      case AppThemeMode.grey:
        themeData = ThemeData(colorSchemeSeed: Colors.grey, useMaterial3: true);
        break;
      case AppThemeMode.pink:
        themeData = ThemeData(colorSchemeSeed: Colors.pink, useMaterial3: true);
        break;
      default:
        themeData = ThemeData.from(
            colorScheme:
                ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.light));
        break;
    }

    if (theme != AppThemeMode.dark) {
      themeData = themeData.copyWith(extensions: [
        AppColorsTheme.light(),
        AppTextsTheme.main(),
        AppDimensionsTheme.main(View.of(_context!))
      ]);
    } else {
      themeData = themeData.copyWith(extensions: [
        AppColorsTheme.light(),
        AppTextsTheme.main(),
        AppDimensionsTheme.main(View.of(_context!))
      ]);
    }

    return themeData;
  }

  Future<ThemeData> init() async {
    if (_context == null) {
      throw "please set context when first use getTheme";
    }
    String? theme = await XYStoreage.read(key: keyThemeColor);
    _themeMode = getThemeMode(theme);
    _theme = getThemeData(_themeMode);
    return _theme!;
  }

  // 改变主题
  static void changeTheme({required AppThemeMode themeMode}) async {
    await XYStoreage.write(key: keyThemeColor, value: getThemeName(themeMode));
    _theme = getThemeData(themeMode);
    _themeMode = themeMode;

    Get.changeTheme(_theme!);
  }

  static AppThemeMode get themeMode {
    return _themeMode!;
  }

  // 获取主题
  Future<ThemeData> getTheme({BuildContext? context}) async {
    if (context != null) _context = context;
    _theme ??= (await init());
    debugPrint(_theme.toString());
    return _theme!;
  }
}
