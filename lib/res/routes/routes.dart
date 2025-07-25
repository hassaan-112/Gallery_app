import 'package:gallery_app/res/routes/routeNames.dart';
import 'package:get/get.dart';

class AppRoutes {
  static appRoutes() => [
    GetPage(name: RouteName.splashScreen, page: () {  }, transition: Transition.fade,transitionDuration: Duration(seconds: 3)),
  ];
}
