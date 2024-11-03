import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/controllers/wonderful_controller.dart';
import 'package:flutter_chatgpt/widgets/favorite_widget.dart';
import 'package:get/get.dart';

class WonderfulPage extends GetView<WonderfulController> {
  const WonderfulPage({super.key});

  get _listView => Obx(() {
        return ListView.builder(
            itemCount: controller.favoriteList.length,
            itemBuilder: (BuildContext context, int index) => Obx(() {
                  return FavoriteWidget(
                    model: controller.favoriteList[index],
                    onLongPress: controller.onLongPress,
                    onTap: controller.jumpToDetail,
                  );
                }));
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("精彩内容"),
        ),
        body: _listView);
  }
}
