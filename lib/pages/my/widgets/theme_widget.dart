import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_chatgpt/pages/my/my_controller.dart';
import 'package:get/get.dart';

class Theme extends GetView<MyController> {
  get _listView {
    // return ListView.builder(itemBuilder: );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(child: _listView);
  }

}