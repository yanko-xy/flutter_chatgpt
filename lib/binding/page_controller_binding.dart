import 'package:flutter_chatgpt/controllers/conversation_controller.dart';
import 'package:flutter_chatgpt/controllers/conversation_list_controller.dart';
import 'package:get/get.dart';

class ConversationControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConversationController>(() => ConversationController());
  }
}

class ConversationListControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConversationListController>(() => ConversationListController());
  }
}
