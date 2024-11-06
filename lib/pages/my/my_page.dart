import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/pages/my/my_controller.dart';
import 'package:flutter_chatgpt/pages/my/widgets/header_widget.dart';
import 'package:flutter_chatgpt/theme/theme_config.dart';
import 'package:flutter_chatgpt/theme/themedata_extension.dart';
import 'package:get/get.dart';

class MyPage extends GetView<MyController> {
  const MyPage({super.key});

  _themeBtn(BuildContext context) {
    return ElevatedButton(
      onPressed: controller.changeTheme,
      style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
        ThemeConfig.theme.appColors.backgroundDefault,
      )),
      child: Text(
        "改变主题",
        style: TextStyle(color: ThemeConfig.theme.appColors.textDefault),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Theme.of(context);
    return Scaffold(
      body: Column(
        children: [
          const HeaderWidget(),
          _themeBtn(context),
        ],
      ),
    );
  }
}
