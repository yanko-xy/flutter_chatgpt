import 'package:flutter_chatgpt/controllers/demo_lang_controller.dart';
import 'package:get/get.dart';

class DemoLangBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DemoLangController>(() => DemoLangController());
  }
}

