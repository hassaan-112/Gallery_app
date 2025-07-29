import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../res/colors/appColors.dart';
import '../utils/Utils.dart';
import '../view_model/HomeScreenVM.dart';
import '../view_model/SettingsVM.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final settingsVM = Get.put(SettingsViewModel());
    final homeVM = Get.put(HomeScreenViewModel());

    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                30.verticalSpace,
                Padding(
                  padding: EdgeInsets.only(left: 25.w),
                  child: Text(
                    "Select Theme",
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                10.verticalSpace,
                RadioListTile(
                  value: 1,
                  groupValue: settingsVM.radioValue.value,
                  onChanged: (value) {
                    setState(() {
                      settingsVM.radioValue.value = 1;
                      settingsVM.changeTheme(ThemeMode.system);
                    });
                  },
                  title: Text("System"),
                ),
                RadioListTile(
                  value: 2,
                  groupValue: settingsVM.radioValue.value,
                  onChanged: (value) {
                    setState(() {
                      settingsVM.radioValue.value = 2;
                      settingsVM.changeTheme(ThemeMode.light);
                    });
                  },
                  title: Text("Light"),
                ),
                RadioListTile(
                  value: 3,
                  groupValue: settingsVM.radioValue.value,
                  onChanged: (value) {
                    setState(() {
                      settingsVM.radioValue.value = 3;
                      settingsVM.changeTheme(ThemeMode.dark);
                    });
                  },
                  title: Text("Dark"),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: GestureDetector(
              onTap: () {
                homeVM.images.clear();
                Utils.toast("Images Cleared", AppColors.positiveGreen);
              },
              child: Container(
                width: double.infinity,
                height: 50.h,
                alignment: Alignment.centerLeft,
                child: Text(
                  "clear_images".tr,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
