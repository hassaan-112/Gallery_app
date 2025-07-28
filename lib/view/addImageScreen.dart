import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_app/res/colors/appColors.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../res/components/ImageBox.dart';
import '../res/components/buttonComponent.dart';
import '../view_model/HomeScreenVM.dart';
class AddImageScreen extends StatefulWidget {
  const AddImageScreen({super.key});

  @override
  State<AddImageScreen> createState() => _AddImageScreenState();
}

class _AddImageScreenState extends State<AddImageScreen> {
  final homeScreenVM = Get.put(HomeScreenViewModel());
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
          Obx(()=>ImageBox(height: 130.r, width:130.r, borderRadius: 20.r, image: homeScreenVM.image,update: homeScreenVM.updater.value,)),
          ButtonComponent(text: "Select Image", onPressed: (){Get.dialog(Dialog(child: ListView( shrinkWrap: true, children: [ListTile(leading: Icon(Icons.camera_alt),title: Text("Camera"),onTap: (){homeScreenVM.selectImage(ImageSource.camera);Get.back();},),Container(color: AppColors.geryContainer,height: 1.h,width: double.infinity,),ListTile(leading: Icon(Icons.photo),title: Text("Gallery"),onTap: (){homeScreenVM.selectImage(ImageSource.gallery);Get.back();},)],)));},color: AppColors.primary,textColor: AppColors.secondaryWhite,width: 110.w,height: 50.h,),
        ],
      ),
          20.verticalSpace,
          ButtonComponent(text: "Add Image", onPressed: (){homeScreenVM.addImage(homeScreenVM.image);},color: AppColors.primary,textColor: AppColors.secondaryWhite,width: 300.w,height: 50.h,)

    ]));
  }
}
