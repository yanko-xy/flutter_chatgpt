import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/pages/my/my_controller.dart';
import 'package:flutter_chatgpt/pages/my/widgets/header_widget.dart';
import 'package:get/get.dart';

class MyPage extends GetView<MyController> {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [HeaderWidget()],
      ),
    );
  }
}
