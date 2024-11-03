import 'package:flutter_chatgpt/controllers/conversation_list_controller.dart';
import 'package:flutter_chatgpt/controllers/wonderful_controller.dart';
import 'package:flutter_chatgpt/stores/demo_store.dart';
import 'package:get/get.dart';

class StoreControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DemoController>(() => DemoController());
    Get.lazyPut<ConversationListController>(() => ConversationListController());
    Get.lazyPut<WonderfulController>(() => WonderfulController());
  }
}
