import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../repository/settingsRepository.dart';

class SettingsViewModel extends GetxController{
  final _settingsRepository = SettingsRepository();
  final currentTheme = ThemeMode.system.obs;
  RxInt radioValue = 1.obs;

  void setRadioValue(int value){radioValue.value=value;}

  changeTheme(ThemeMode themeMode){
    _settingsRepository.saveThemeMode(themeMode);
    currentTheme.value = themeMode;
    Get.changeThemeMode(themeMode);
  }
  getTheme()async{
    final theme =await _settingsRepository.getThemeMode();
    currentTheme.value = theme;
    radioValue.value = theme == ThemeMode.light ? 2 : theme == ThemeMode.dark ? 3 : 1;
  }


}