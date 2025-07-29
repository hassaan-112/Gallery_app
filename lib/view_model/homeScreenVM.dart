import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../res/colors/appColors.dart';
import '../utils/Utils.dart';

class HomeScreenViewModel extends GetxController {
  File? image = null;
  RxList images=[].obs;
  RxBool updater = false.obs;

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
  void addImage(File? image){

    if(this.image==null){
      Utils.toast("p_select_image".tr, AppColors.negativeRed);
      return;
    }
    images.add(image);
    this.image=null;
    updater.value=!updater.value;
    Utils.toast("image_added".tr, AppColors.positiveGreen);
  }
  void removeImage(int index){
    images.removeAt(index);
  }

}
