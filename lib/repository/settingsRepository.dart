import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SettingsRepository{

  void saveThemeMode(ThemeMode themeMode)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (themeMode == ThemeMode.light) {
      prefs.setString("theme", "light");
    } else if (themeMode == ThemeMode.dark) {
      prefs.setString("theme", "dark");
    } else {
      prefs.setString("theme", "system");
    }
  }

  Future<ThemeMode> getThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? theme = prefs.getString("theme");
    if (theme == "light") {
      return ThemeMode.light;
    } else if (theme == "dark") {
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }
}