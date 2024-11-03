import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/controllers/demo_second_controller.dart';
import 'package:flutter_chatgpt/models/animal_model.dart';
import 'package:flutter_chatgpt/models/person_model.dart';
import 'package:get/get.dart';

import '../stores/demo_store.dart';

class DemoPage extends StatefulWidget {

  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final RxInt _count = 0.obs;
  final RxString _username = "yanko".obs;
  final RxList _list = ["xiaoyang", "yanko"].obs;
  final PersonModel persion = PersonModel();
  final Rx<AnimalModel> animal = AnimalModel("mao", 18).obs;

  DemoController demoController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Demo"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => Text(
                "${_count.value}",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            const SizedBox(),
            Obx(() {
              return Text(
                _username.value,
                style: Theme.of(context).textTheme.headlineSmall,
              );
            }),
            const SizedBox(),
            Obx(() => Column(
                  children: _list.map((v) {
                    return ListTile(
                      title: Text(v),
                    );
                  }).toList(),
                )),
            const SizedBox(),
            Obx(
              () => Text(
                "${persion.username}",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            const SizedBox(),
            Obx(
              () => Text(
                animal.value.username,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            const SizedBox(),
            Obx(
              () => Text(
                "${demoController.counter}",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            const SizedBox(),
            ElevatedButton(
                onPressed: () {
                  Get.toNamed("demo2");
                },
                child: const Text("second page"))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          heroTag: "demo",
          onPressed: () {
            _count.value++;
            _username.value = "xiayuang";
            _list.add("ceshi");
            persion.username.value = persion.username.value.toUpperCase();
            animal.value.username = "效果剖";
            animal.value = animal.value;
            demoController.inc();

            Get.snackbar("提示", "简单的测试一下");
          }),
    );
  }
}
