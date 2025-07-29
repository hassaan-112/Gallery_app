import 'package:flutter/material.dart';
import 'package:gallery_app/view/settings.dart';
import 'package:gallery_app/view/searchScreen.dart';
import '../view_model/bottomNavVM.dart';
import 'package:get/get.dart';
import 'homeScreen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    final navBarVM = Get.put(NavBarViewModel());
    List<Widget> pages = [HomeScreen(),SearchScreen(),SettingsScreen()];

    return Scaffold(
      body: Obx(()=> IndexedStack(index: navBarVM.index, children: pages)),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          onTap: (value) {
            navBarVM.setIndex(value);
          },
          currentIndex: navBarVM.index,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "home".tr,
            ),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "search".tr),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              label: "settings".tr,
            ),
          ],
        ),
      ),
    );
  }
}
