import 'package:flutter/material.dart';
import 'package:gallery_app/res/colors/appColors.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../res/components/ImageBox.dart';
import '../res/components/buttonComponent.dart';
class AddImageScreen extends StatefulWidget {
  const AddImageScreen({super.key});

  @override
  State<AddImageScreen> createState() => _AddImageScreenState();
}

class _AddImageScreenState extends State<AddImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Image"),
        centerTitle: true,
        actions:[
          IconButton(onPressed: (){
            Get.changeThemeMode(Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
          }, icon: Icon(Get.isDarkMode?Icons.light_mode:Icons.dark_mode))
        ]
      ),
      body: Column(
        children: [
          20.verticalSpace,
        Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ImageBox(height: 130.r, width:130.r, borderRadius: 20.r, image: null),
          ButtonComponent(text: "Add Image", onPressed: (){},color: AppColors.primary,textColor: AppColors.secondaryWhite,width: 110.w,height: 50.h,),
        ],
      )
    ]));
  }
}
