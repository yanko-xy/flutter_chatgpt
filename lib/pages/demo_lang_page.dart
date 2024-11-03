import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/controllers/demo_lang_controller.dart';
import 'package:get/get.dart';

class DemoLangPage extends GetView<DemoLangController> {
  const DemoLangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("国际化"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("hello".tr),
            const SizedBox(),
            Text("title".tr),
            ElevatedButton(
                onPressed: () {
                  Get.updateLocale(const Locale("zh", "CN"));
                },
                child: const Text("切换到中文")),
            ElevatedButton(
                onPressed: () {
                  Get.updateLocale(const Locale("en", "SU"));
                },
                child: const Text("切换到英文"))
          ],
        ),
      ),
    );
  }
}
