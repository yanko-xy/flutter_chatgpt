import 'package:flutter_chatgpt/binding/demo_getutil_binding.dart';
import 'package:flutter_chatgpt/binding/demo_lang_binding.dart';
import 'package:flutter_chatgpt/binding/demo_second_binding.dart';
import 'package:flutter_chatgpt/middleware/damo_middleware.dart';
import 'package:flutter_chatgpt/pages/bottom_navigator.dart';
import 'package:flutter_chatgpt/pages/conversation_list_page.dart';
import 'package:flutter_chatgpt/pages/conversation_page.dart';
import 'package:flutter_chatgpt/pages/demo_getuitl_page.dart';
import 'package:flutter_chatgpt/pages/demo_lang_page.dart';
import 'package:flutter_chatgpt/pages/demo_page.dart';
import 'package:flutter_chatgpt/pages/demo_second_page.dart';
import 'package:get/get.dart';
import 'package:login_sdk/pages/login_page.dart';

import '../binding/page_controller_binding.dart';

class RouteConfig {
  static final routes = [
    GetPage(
      name: "/",
      page: () => const BottomNavigator(),
    ),
    GetPage(
      name: "/login",
      page: () => const LoginPage(),
    ),
    GetPage(
      name: "/demo",
      page: () => const DemoPage(),
    ),
    GetPage(
      name: "/conversation",
      page: () => const ConversationPage(),
      binding: ConversationControllerBinding(),
    ),
    GetPage(
        name: "/demo2",
        page: () => DemoSecondPage(),
        binding: DemoSecondBinding(),
        middlewares: [DemoMiddleware()]),
    GetPage(
      name: "/demo_lang",
      page: () => const DemoLangPage(),
      binding: DemoLangBinding(),
    ),
    GetPage(
      name: "/demo_getutil",
      page: () => DemoGetUitlPage(),
      binding: DemoGetUtilBinding(),
    )
  ];

  static const defaultTransition = Transition.rightToLeft;
}
