import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/pages/my/my_controller.dart';
import 'package:flutter_chatgpt/pages/my/widgets/header_widget.dart';
import 'package:flutter_chatgpt/theme/themedata_extension.dart';
import 'package:get/get.dart';

class MyPage extends GetView<MyController> {
  const MyPage({super.key});

  _themeBtn(BuildContext context) {
    return ElevatedButton(
      onPressed: controller.changeTheme,
      style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
        Theme.of(context).appColors.backgroundDefault,
      )),
      child: const Text("改变主题"),
    );
  }

  @override
  Widget build(BuildContext context) {
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
