import 'package:chat_message/utils/wechat_date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/models/conversation_model.dart';
import 'package:flutter_chatgpt/utils/xy_dialog.dart';
import 'package:login_sdk/utils/padding_extension.dart';

// 定义一个带有ConversationModel参数的回调
typedef ConversationCallback = Function(ConversationModel model);
typedef ConversationStickCallback = Function(ConversationModel model, {required bool isStick});

class ConversationWidget extends StatelessWidget {
  final ConversationModel model;
  final ConversationCallback? onPressed;
  final ConversationCallback? onDelete;
  final ConversationStickCallback? onStick;

  const ConversationWidget(
      {super.key, required this.model, this.onPressed, this.onDelete, this.onStick});

  get _item => Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        color: _itemBackgroundColor,
        height: 76,
        child: Row(
          children: [_icon, 10.paddingWidth, _rightLayout],
        ),
      );

  get _itemBackgroundColor => model.stickTime > 0 ? Colors.grey.withOpacity(0.2) : Colors.white;

  get _icon => ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.network(
          model.icon,
          width: 50,
          height: 50,
        ),
      );

  get _rightLayout => Expanded(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              5.paddingHeight,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Text(
                    model.title ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 18),
                  )),
                  Text(
                    WeChatDateFormat.format(model.updatedAt ?? 0),
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                  )
                ],
              ),
              Text(
                "[${model.messageCount}条对话]  ${model.lastMessage}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              )
            ],
          ),
          Divider(
            height: 1,
            color: Colors.grey.withOpacity(0.6),
          )
        ],
      ));

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onPressed != null) onPressed!(model);
      },
      onLongPress: () => _showPopMenu(context),
      child: _item,
    );
  }

  // 在item下方弹窗，难点如何找到要弹框的坐标位置
  _showPopMenu(BuildContext context) {
    var isStick = model.stickTime > 0 ? true : false;
    var showStick = isStick ? "取消置顶" : "置顶";
    XYDialog.showPopMenu(context, offsetX: -50, items: [
      PopupMenuItem(
        child: Text(showStick),
        onTap: () {
          if (onStick != null) onStick!(model, isStick: !isStick);
        },
      ),
      PopupMenuItem(
        child: const Text("删除"),
        onTap: () {
          if (onDelete != null) onDelete!(model);
        },
      )
    ]);
  }
}
