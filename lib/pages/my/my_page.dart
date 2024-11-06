import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/pages/my/my_controller.dart';
import 'package:flutter_chatgpt/pages/my/widgets/header_widget.dart';
import 'package:get/get.dart';

class MyPage extends GetView<MyController> {
  const MyPage({super.key});

  get _themeBtn {
    return ElevatedButton(
      onPressed: controller.changeTheme,
      child: const Text("改变主题"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const HeaderWidget(),
          _themeBtn,
        ],
      ),
    );
  }
}
