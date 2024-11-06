import 'package:flutter_chatgpt/models/user_model.dart';
import 'package:flutter_chatgpt/theme/theme_config.dart';
import 'package:flutter_chatgpt/theme/app_theme_mode.dart';
import 'package:get/get.dart';
import 'package:login_sdk/dao/login_dao.dart';

class MyController extends GetxController {
  late Rx<UserModel> _userModel;

  UserModel get userModel => _userModel.value;

  set userModel(val) => _userModel.value = val;

  @override
  void onInit() {
    Map<String, dynamic>? json = LoginDao.getUserInfo();
    if (json != null) {
      _userModel = Rx(UserModel.fromJson(json));
    }
    super.onInit();
  }

  void changeTheme() {
    ThemeConfig.changeTheme(themeMode: AppThemeMode.system);
  }
}
