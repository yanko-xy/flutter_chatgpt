import 'package:chat_message/utils/wechat_date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/models/favorite_model.dart';
import 'package:login_sdk/utils/padding_extension.dart';

typedef OnFavoriteClick = void Function(FavoriteModel model, BuildContext ancestor);

class FavoriteWidget extends StatelessWidget {
  final FavoriteModel model;
  final OnFavoriteClick onLongPress;
  final OnFavoriteClick onTap;

  const FavoriteWidget({
    super.key,
    required this.model,
    required this.onLongPress,
    required this.onTap,
  });

  get _titleView {
    return Text(
      model.content,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    );
  }

  get _bottomLayout {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          model.ownerName ?? "",
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
        Text(
          WeChatDateFormat.format(model.createdAt!),
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () => onLongPress(model, context),
      onTap: () => onTap(model, context),
      child: Card(
        margin: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _titleView,
              20.paddingHeight,
              _bottomLayout,
            ],
          ),
        ),
      ),
    );
  }
}
