import 'package:flutter_chatgpt/pages/conversation_list/conversation_list_controller.dart';
import 'package:get/get.dart';

class ConversationListControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ConversationListController());
  }
}
