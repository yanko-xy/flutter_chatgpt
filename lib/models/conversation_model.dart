import 'package:get/get.dart';

class ConversationModel {
  int? id;
  int cid;
  String? title;
  String icon;
  int? updatedAt;
  int stickTime;
  int? messageCount;

  String? lastMessage;

  ///会话消息是否有变化
  bool hadChanged = false;

  ConversationModel(
      {this.id,
      required this.cid,
      this.title,
      required this.icon,
      this.updatedAt,
      this.stickTime = 0,
      this.messageCount,
      this.lastMessage});

  factory ConversationModel.fromJson(Map<String, dynamic> json) => ConversationModel(
      id: json['id'],
      cid: json['cid'],
      title: json['title'],
      icon: json['icon'],
      updatedAt: json['updatedAt'],
      stickTime: json['stickTime'],
      messageCount: json['messageCount'],
      lastMessage: json['lastMessage']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cid'] = cid;
    data['title'] = title;
    data['icon'] = icon;
    data['updatedAt'] = updatedAt;
    data['stickTime'] = stickTime;
    data['messageCount'] = messageCount;
    data['lastMessage'] = lastMessage;
    return data;
  }
}
