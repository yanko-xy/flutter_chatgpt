import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/controllers/demo_second_controller.dart';
import 'package:flutter_chatgpt/stores/demo_store.dart';
import 'package:get/get.dart';

class DemoSecondPage extends GetView<DemoSecondController> {
  DemoSecondPage({super.key});

  final DemoController demoController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Demo2"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Text(
                  "${demoController.counter}",
                  style: Theme.of(context).textTheme.headlineLarge,
                )),
            const SizedBox(),
            Obx(() => Text(
                  "${controller.counter}",
                  style: Theme.of(context).textTheme.headlineLarge,
                )),
            ElevatedButton(
                onPressed: () {
                  demoController.dec();
                  controller.inc();
                },
                child: const Text("update")),
            ElevatedButton(
                onPressed: () {
                  Get.toNamed("demo_lang");
                },
                child: const Text("国际化")),
            ElevatedButton(
                onPressed: () {
                  Get.toNamed("demo_getutil");
                },
                child: const Text("getUtil"))
          ],
        ),
      ),
    );
  }
}
