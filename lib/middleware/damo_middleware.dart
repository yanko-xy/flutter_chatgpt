import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class DemoMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    debugPrint("middleware");
    // TODO: 路由拦截
    // return const RouteSettings(name: "demo", arguments: {});
    return null;
  }
}
