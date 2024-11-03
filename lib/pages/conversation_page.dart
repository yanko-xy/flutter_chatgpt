import 'package:chat_message/widgets/chat_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/controllers/conversation_controller.dart';
import 'package:flutter_chatgpt/models/conversation_model.dart';
import 'package:flutter_chatgpt/widgets/message_input_widget.dart';
import 'package:get/get.dart';

typedef OnConversationUpdate = void Function(ConversationModel conversationModel);

class ConversationPage extends GetView<ConversationController> {
  const ConversationPage({super.key});

  get _chatList => Expanded(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: ChatListWidget(
            chatController: controller.chatController,
            onBubbleLongPress: controller.onBubbleLongPress,
          ),
        ),
      );

  get _inputWidget {
    return Obx(() {
      return MessageInputWidget(
        hint: "请输入",
        enable: controller.sendBtnEnable,
        onChanged: (text) => controller.inputMessage = text,
        onSend: () => controller.onSend(controller.inputMessage),
      );
    });
  }

  get _appBar => AppBar(
      centerTitle: true,
      title: Obx(() {
        return Text(controller.title);
      }));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: Column(
        children: [_chatList, _inputWidget],
      ),
    );
  }
}
