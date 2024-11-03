import 'package:flutter_chatgpt/controllers/demo_getutil_controller.dart';
import 'package:get/get.dart';

class DemoGetUtilBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DemoGetUtilController>(() => DemoGetUtilController());
  }
}
