import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/controllers/demo_lang_controller.dart';
import 'package:get/get.dart';

class DemoGetUitlPage extends GetView<DemoLangController> {
  DemoGetUitlPage({super.key});

  final TextEditingController _editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("GetUtil"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _editingController,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  if (GetUtils.isEmail(_editingController.text)) {
                    Get.snackbar("正确", "");
                  } else {
                    Get.snackbar("错误", "");
                  }
                },
                child: const Text("验证邮箱"))
          ],
        ),
      ),
    );
  }
}
