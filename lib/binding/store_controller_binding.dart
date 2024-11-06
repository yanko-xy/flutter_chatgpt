import 'package:flutter_chatgpt/pages/conversation_list/conversation_list_controller.dart';
import 'package:flutter_chatgpt/pages/wonderful/wonderful_controller.dart';
import 'package:flutter_chatgpt/stores/demo_store.dart';
import 'package:flutter_chatgpt/stores/wonderful_store.dart';
import 'package:get/get.dart';

class StoreControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<DemoController>(DemoController());
    Get.put<WonderfulStore>(WonderfulStore());
  }
}
