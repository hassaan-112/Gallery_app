import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsViewModel extends GetxController{

  final currentTheme = ThemeMode.system.obs;
  RxInt radioValue = 1.obs;

  changeTheme(ThemeMode themeMode){
    currentTheme.value = themeMode;
    Get.changeThemeMode(themeMode);
  }

}