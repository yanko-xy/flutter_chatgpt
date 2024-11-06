import 'package:flutter_chatgpt/controllers/conversation_controller.dart';
import 'package:flutter_chatgpt/pages/conversation_list/conversation_list_controller.dart';
import 'package:flutter_chatgpt/pages/message_detail/message_detail_controller.dart';
import 'package:get/get.dart';

class ConversationControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConversationController>(() => ConversationController());
  }
}
