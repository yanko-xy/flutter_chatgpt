import 'package:flutter_chatgpt/pages/message_detail/message_detail_controller.dart';
import 'package:get/get.dart';

class MessageDetailControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MessageDetailController>(() => MessageDetailController());
  }
}