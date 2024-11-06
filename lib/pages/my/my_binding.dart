import 'package:flutter_chatgpt/pages/my/my_controller.dart';
import 'package:get/get.dart';

class MyControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyController());
  }
}
