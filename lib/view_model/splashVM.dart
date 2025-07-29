import 'package:get/get.dart';

import '../repository/settingsRepository.dart';

class SplashScreenViewMoodel extends GetxController{

  final _settingsRepository = SettingsRepository();
  void splashScreen(){
    Get.offAndToNamed('/homeScreen');
  }

  getTheme()async{
    final theme =await _settingsRepository.getThemeMode();
    Get.changeThemeMode(theme);
  }
}