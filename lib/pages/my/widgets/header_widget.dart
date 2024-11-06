import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/pages/my/my_controller.dart';
import 'package:get/get.dart';
import 'package:login_sdk/dao/login_dao.dart';
import 'package:login_sdk/utils/padding_extension.dart';

class HeaderWidget extends GetView<MyController> {
  const HeaderWidget({super.key});

  get _avatar {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Image.network(
        controller.userModel.avatar!,
        height: 60,
        width: 60,
      ),
    );
  }

  get _rightLayout {
    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          controller.userModel.userName ?? "",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Text(
          "imooc id: ${controller.userModel.imoocId}",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 13, color: Colors.grey),
        )
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60),
      child: Row(
        children: [
          20.paddingWidth,
          if (controller.userModel.avatar != null) _avatar,
          15.paddingWidth,
          _rightLayout,
          _logoutBtn(Colors.blue),
          20.paddingWidth,
        ],
      ),
    );
  }

  _logoutBtn(MaterialColor color) {
    return GestureDetector(
      onTap: () => LoginDao.logOut(),
      child: Icon(
        Icons.logout,
        color: color,
      ),
    );
  }
}
