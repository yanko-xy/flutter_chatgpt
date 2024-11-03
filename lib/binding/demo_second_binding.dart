import 'package:flutter_chatgpt/controllers/demo_second_controller.dart';
import 'package:get/get.dart';

class DemoSecondBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DemoSecondController>(() => DemoSecondController());
  }
}
