import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../res/colors/appColors.dart';
import '../utils/Utils.dart';
import '../view_model/homeScreenVM.dart';
import '../view_model/settingsVM.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final settingsVM = Get.put(SettingsViewModel());

  @override
  void initState() {
    super.initState();
    settingsVM.getTheme();
  }
  @override
  Widget build(BuildContext context) {
    final settingsVM = Get.put(SettingsViewModel());
    final homeVM = Get.put(HomeScreenViewModel());

    return Scaffold(
      appBar: AppBar(title: Text("settings".tr), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.r),
        child: Column(
          children: [
            Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  30.verticalSpace,
                  Text(
                    "select_theme".tr,
                    style: Theme.of(context).textTheme.displayMedium
                  ),
                  10.verticalSpace,
                  RadioListTile(
                    value: 1,
                    groupValue: settingsVM.radioValue.value,
                    onChanged: (value) {
                      if (value != null) {
                        settingsVM.setRadioValue(value);
                        settingsVM.changeTheme(ThemeMode.system);
                      }
                    },
                    title: Text("system".tr),
                  ),
                  RadioListTile(
                    value: 2,
                    groupValue: settingsVM.radioValue.value,
                    onChanged: (value) {
                      if (value != null) {
                        settingsVM.setRadioValue(value);
                        settingsVM.changeTheme(ThemeMode.light);
                      }
                    },
                    title: Text("light".tr),
                  ),
                  RadioListTile(
                    value: 3,
                    groupValue: settingsVM.radioValue.value,
                    onChanged: (value) {
                      if (value != null) {
                        settingsVM.setRadioValue(value);
                        settingsVM.changeTheme(ThemeMode.dark);
                      }
                    },
                    title: Text("dark".tr),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: GestureDetector(
                onTap: () {
                  homeVM.images.clear();
                  Utils.toast("images_cleared".tr, AppColors.positiveGreen);
                },
                child: Container(
                  width: double.infinity,
                  height: 50.h,
                  alignment: Alignment.center,
                  child: Text(
                    "clear_images".tr,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: GestureDetector(
                onTap: () {
                  settingsVM.changeLanguage();
                },
                child: Container(
                  width: double.infinity,
                  height: 50.h,
                  alignment: Alignment.center,
                  child: Text(
                    "switch_language".tr,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
