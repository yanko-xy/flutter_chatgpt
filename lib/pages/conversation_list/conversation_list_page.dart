import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/pages/conversation_list/conversation_list_controller.dart';
import 'package:flutter_chatgpt/widgets/app_bar_widget.dart';
import 'package:get/get.dart';

class ConversationListPage extends GetView<ConversationListController> {
  const ConversationListPage({super.key});

  get _listView => ListView.builder(
      itemCount: controller.dataCount,
      itemBuilder: (BuildContext context, int index) => controller.conversationWidget(index));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: "Easy Chat",
      ),
      body: Obx(() => _listView),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.createConversation,
        tooltip: "新建会话",
        child: const Icon(Icons.add),
      ),
    );
  }
}
