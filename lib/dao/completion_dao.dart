import 'package:chat_message/models/message_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_chatgpt/utils/conversation_context_help.dart';
import 'package:openai_flutter/core/ai_completion.dart';
import 'package:openai_flutter/utils/ai_logger.dart';

class CompletionDao {
  final IConversationContext conversationContextHelper = ConversationContextHelp();

  // 初始化会话上下文
  CompletionDao({List<MessageModel>? messages}) {
    MessageModel? question, answer;
    messages?.forEach((model) {
      // sender为提问者， receiver为回答者
      if (model.ownerType == OwnerType.sender) {
        question = model;
      } else {
        answer = model;
      }

      if (question != null && answer != null) {
        conversationContextHelper.add(ConversationModel(question!.content, answer!.content));
        question = answer = null;
      }
    });
    AILogger.log("init finish, prompt is ${conversationContextHelper.getPromptContext('')}");
  }

  // 与chatGPT进行会话
  Future<String?> createCompletions({required String prompt}) async {
    var fullPrompt = conversationContextHelper.getPromptContext(prompt);
    debugPrint("fullPrompt: $fullPrompt");
    var response = await AICompletion().createChat(prompt: prompt, maxTokens: 1000);
    var choices = response.choices?.first;
    var content = choices?.message?.content;
    if (content != null) {
      var list = content.split("A:");
      content = list.length > 1 ? list[1] : content;
      content = content.replaceFirst("\n\n", "");
      conversationContextHelper.add(ConversationModel(prompt, content));
    }
    return content;
  }
}
