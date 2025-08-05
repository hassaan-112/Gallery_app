import 'package:flutter/material.dart';
import 'package:gallery_app/res/colors/appColors.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../permissions.dart';
import '../res/components/ImageBox.dart';
import '../res/components/buttonComponent.dart';
import '../res/components/textFormFieldComponent.dart';
import '../utils/Utils.dart';
import '../view_model/homeScreenVM.dart';

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
      appBar: AppBar(title: Text("add_image".tr), centerTitle: true),
      body: Column(
        children: [
          20.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Obx(
                () => ImageBox(
                  height: 130.r,
                  width: 130.r,
                  borderRadius: 20.r,
                  image: homeScreenVM.image,
                  update: homeScreenVM.updater.value,
                ),
              ),
              ButtonComponent(
                text: "select_image".tr,
                onPressed: ()async {

                  await Permissions.requestAllPermissions();
                  Get.dialog(
                    Dialog(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          ListTile(
                            leading: Icon(Icons.camera_alt),
                            title: Text("camera".tr),
                            onTap: () {
                              homeScreenVM.selectImage(ImageSource.camera);
                              Get.back();
                            },
                          ),
                          Container(
                            color: AppColors.geryContainer,
                            height: 1.h,
                            width: double.infinity,
                          ),
                          ListTile(
                            leading: Icon(Icons.photo),
                            title: Text("gallery".tr),
                            onTap: () {
                              homeScreenVM.selectImage(ImageSource.gallery);
                              Get.back();
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
                color: AppColors.primary,
                textColor: AppColors.secondaryWhite,
                width: 110.w,
                height: 50.h,
              ),
            ],
          ),
          20.verticalSpace,
          Form(
            key: homeScreenVM.formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(children: [
                TextFormFieldComponent(hintText: "title", controller: homeScreenVM.titleController, keyboardType: TextInputType.text, focusNode: homeScreenVM.titleFocusNode, validator: (value){if(value!.isEmpty){return "enter_title".tr;}}, onSubmited:(value){Utils.fieldFocusChange(context, homeScreenVM.titleFocusNode, homeScreenVM.descriptionFocusNode);}, onTapedOutside: (v){homeScreenVM.titleFocusNode.unfocus();}),
                10.verticalSpace,
                TextFormFieldComponent(hintText: "description", controller: homeScreenVM.descriptionController, keyboardType: TextInputType.text, focusNode: homeScreenVM.descriptionFocusNode, validator: (value){}, onSubmited:(value){homeScreenVM.descriptionFocusNode.unfocus();}, onTapedOutside: (v){homeScreenVM.descriptionFocusNode.unfocus();}),
                30.verticalSpace,
              ],),
            ),),
          Obx(()=>ButtonComponent(
              isLoading: homeScreenVM.loading.value,
              text: "add_image".tr,
              onPressed: () {
                homeScreenVM.addImage(homeScreenVM.image);
              },
              color: AppColors.primary,
              textColor: AppColors.secondaryWhite,
              width: 300.w,
              height: 50.h,
            ),
          ),
        ],
      ),
    );
  }
}
