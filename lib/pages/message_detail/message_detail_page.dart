import 'package:chat_message/utils/wechat_date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/pages/message_detail/message_detail_controller.dart';
import 'package:get/get.dart';

class MessageDetailPage extends GetView<MessageDetailController> {
  const MessageDetailPage({super.key});

  _titleView() {
    return Column(
      children: [
        const Text(
          "详情",
          style: TextStyle(fontSize: 16),
        ),
        Text(
          "来自 ${controller.model.ownerName} ${WeChatDateFormat.fromatYMd(controller.model.createdAt!)}",
          style: const TextStyle(fontSize: 12),
        )
      ],
    );
  }

  _listView(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 20, bottom: 20, left: 15, right: 15),
      children: [
        _content(context),
      ],
    );
  }

  _content(BuildContext context) {
    return InkWell(
      onLongPress: () => controller.onLongPress(context),
      onTapDown: controller.onTapDown,
      child: Text(
        controller.model.content,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: _titleView(),
      ),
      body: _listView(context),
    );
  }
}
