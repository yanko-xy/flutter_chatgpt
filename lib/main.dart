import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/binding/store_controller_binding.dart';
import 'package:flutter_chatgpt/lang/language.dart';
import 'package:flutter_chatgpt/pages/bottom_navigator.dart';
import 'package:flutter_chatgpt/router/route_config.dart';
import 'package:login_sdk/dao/login_dao.dart';
import 'package:login_sdk/login_sdk.dart';
import 'package:login_sdk/pages/login_page.dart';
import 'package:openai_flutter/http/ai_config.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
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
  }

  Future<void> doInit() async {
    await LoginConfig.instance().init(homePage: const BottomNavigator());
    AIConfigBuilder.init(
        "");
    AIConfigBuilder.instance.setProxy("192.168.1.8:7890");
  }
}
