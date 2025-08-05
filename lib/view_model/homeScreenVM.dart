import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../model/localPicModel.dart';
import '../repository/imagesRepository.dart';
import '../res/colors/appColors.dart';
import '../utils/Utils.dart';

class HomeScreenViewModel extends GetxController {
  RxBool detail = true.obs;
  RxInt lIndex = 0.obs;
  File? image = null;
  RxList images=[].obs;
  RxBool loading = false.obs;
  RxBool updater = false.obs;
  RxInt selectedIndex=0.obs;
  final _imgRepo = ImagesRepository();
  final localImages=<Local_Picture>[].obs;

  // form
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final titleFocusNode = FocusNode();
  final descriptionFocusNode = FocusNode();


  Future<void> getLocalImages() async {

    localImages.value=await _imgRepo.getImages();
    print(localImages.length);
    Utils.toast("in db ${localImages.length.toString()}", AppColors.primary);
    await toFileList();
    updater.value=!updater.value;
  }


  Future<void> toFileList() async {
    final appDir = await getApplicationDocumentsDirectory();
    images.value = [];

    for (int i = 0; i < localImages.length; i++) {
      final file = File('${appDir.path}/image$i.jpg');
      print(file.path);
      if (!file.existsSync()) {
        await file.writeAsBytes(localImages[i].image!);
      }


      images.add(file);
      print(images.length);
    }
  }


  Future<void> selectImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);
    if (pickedImage != null) {
      image = File(pickedImage.path);
      updater.value=!updater.value;
    } else {
      updater.value=!updater.value;
      return;
    }
  }
  void addImage(File? image)async {
    if (loading.value) {}
    else {
      loading.value = true;
      if (this.image == null) {
        Utils.toast("p_select_image".tr, AppColors.negativeRed);
        loading.value = false;
        return;
      }
      await _imgRepo.addImage(this.image!);
      getLocalImages();
      this.image = null;
      updater.value = !updater.value;
      Utils.toast("image_added".tr, AppColors.positiveGreen);
      loading.value = false;
    }
  }
  void removeImage(int index){
    _imgRepo.deleteImage(localImages[index].id!);
    images.removeAt(index);
    localImages.removeAt(index);
    updater.value=!updater.value;
    if(images.isEmpty){
      Get.back();
    }
  }
  void deleteAll(){
    _imgRepo.deleteAll();
    images.clear();
    localImages.clear();
    updater.value=!updater.value;
  }

}
