import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/binding/store_controller_binding.dart';
import 'package:flutter_chatgpt/lang/language.dart';
import 'package:flutter_chatgpt/pages/bottom_navigator.dart';
import 'package:flutter_chatgpt/router/route_config.dart';
import 'package:flutter_chatgpt/theme/theme_config.dart';
import 'package:flutter_chatgpt/utils/xy_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:login_sdk/dao/login_dao.dart';
import 'package:login_sdk/login_sdk.dart';
import 'package:login_sdk/pages/login_page.dart';
import 'package:openai_flutter/http/ai_config.dart';
import 'package:get/get.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() {
  // 初始话本地仓库
  XYStoreage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ThemeConfig.getTheme(context: context),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return GetMaterialApp(
              title: 'Flutter Demo',
              theme: snapshot.data as ThemeData,
              initialBinding: StoreControllerBinding(),
              translations: Messages(),
              locale: const Locale("zh", "CN"),
              fallbackLocale: const Locale("en", "US"),
              defaultTransition: RouteConfig.defaultTransition,
              getPages: RouteConfig.routes,
              home: FutureBuilder(
                  future: doInit(),
                  builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (LoginDao.getBoardingPass() == null) {
                        return const LoginPage();
                      } else {
                        return const BottomNavigator();
                      }
                    } else {
                      return const Scaffold(
                        body: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  }),
            );
          } else {
            return Container();
          }
        });
  }

  Future<void> doInit() async {
    await LoginConfig.instance()
        .init(homePage: const BottomNavigator(), goHomeFn: () => Get.offNamed("home"));
    await dotenv.load(fileName: ".env");

    AIConfigBuilder.init(dotenv.env['BASE_URL']!);
    AIConfigBuilder.instance.setProxy("192.168.1.8:7890");
  }
}
