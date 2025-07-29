import 'package:gallery_app/res/routes/routeNames.dart';
import 'package:gallery_app/view/bottomNav.dart';
import 'package:gallery_app/view/settings.dart';
import 'package:gallery_app/view/splashScreen.dart';
import 'package:gallery_app/view/addImageScreen.dart';
import 'package:gallery_app/view/searchScreen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static appRoutes() => [
    GetPage(name: RouteName.splashScreen, page: () { return Splashscreen(); }, transition: Transition.fadeIn,transitionDuration: Duration(seconds: 3)),
    GetPage(name: RouteName.homeScreen, page: () { return BottomNavBar(); }, transition: Transition.fadeIn,transitionDuration: Duration(seconds: 2)),
    GetPage(name: RouteName.addImageScreen, page: () { return AddImageScreen(); }, transition: Transition.fadeIn,transitionDuration: Duration(milliseconds: 1000)),
    GetPage(name: RouteName.SearchScreen, page: () { return SearchScreen(); }, transition: Transition.fadeIn,transitionDuration: Duration(milliseconds: 1000)),
    GetPage(name: RouteName.SettingsScreen, page: () { return SettingsScreen(); }, transition: Transition.fadeIn,transitionDuration: Duration(milliseconds: 1000)),
  ];
}
