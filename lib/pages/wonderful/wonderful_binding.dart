import 'package:flutter_chatgpt/pages/wonderful/wonderful_controller.dart';
import 'package:get/get.dart';

class WonderfulControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WonderfulController());
  }
}
