import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_saver_plus/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../model/localPicModel.dart';
import '../repository/imagesRepository.dart';
import '../res/colors/appColors.dart';
import '../utils/Utils.dart';

class LocalImagesViewModel extends GetxController {
  // variables
  RxBool detail = true.obs;
  RxInt lIndex = 0.obs;
  RxInt selectedIndex = 0.obs;
  RxBool loading = false.obs;
  RxBool updater = false.obs;
  RxBool downloadingStatus = false.obs;

  File? image;
  RxList<File> images = <File>[].obs;
  final localImages = <Local_Picture>[].obs;

  final _imgRepo = ImagesRepository();

  // Form-related
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final titleFocusNode = FocusNode();
  final descriptionFocusNode = FocusNode();


  Future<void> getLocalImages() async {
    localImages.value = await _imgRepo.getImages();
    print(localImages.length);

    Utils.toast("in db ${localImages.length}", AppColors.primary);
    await toFileList();

    updater.value = !updater.value;
  }

  Future<void> toFileList() async {
    final appDir = await getApplicationDocumentsDirectory();
    images.clear();

    for (int i = 0; i < localImages.length; i++) {
      final file = File('${appDir.path}/image$i.jpg');

      if (!file.existsSync()) {
        await file.writeAsBytes(localImages[i].image!);
      }

      images.add(file);
    }
  }


  Future<void> selectImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      image = File(pickedImage.path);
    }

    updater.value = !updater.value;
  }


  void addImage(File? image) async {
    if (loading.value) return;

    if (formKey.currentState!.validate()) {
      loading.value = true;

      if (this.image == null) {
        Utils.toast("p_select_image".tr, AppColors.negativeRed);
        loading.value = false;
        return;
      }

      await _imgRepo.addImage(
        this.image!,
        titleController.text,
        descriptionController.text,
      );

      await getLocalImages();

      this.image = null;
      titleController.clear();
      descriptionController.clear();
      updater.value = !updater.value;
      loading.value = false;
    } else {
      Utils.toast("enter_all_fields".tr, AppColors.negativeRed);
    }
  }


  void removeImage(int index) {
    _imgRepo.deleteImage(localImages[index].id!);
    images.removeAt(index);
    localImages.removeAt(index);
    updater.value = !updater.value;

    if (images.isEmpty) {
      Get.back();
    }
  }


  void deleteAll() {
    _imgRepo.deleteAll();
    images.clear();
    localImages.clear();
    updater.value = !updater.value;
  }

  void saveToGallery(String path) async {
    downloadingStatus.value = true;

    try {
      bool? success = await GallerySaver.saveImage(
        path,
        albumName: 'Gallery App',
      );

      if (success == true) {
        Utils.toast("Image Saved", AppColors.positiveGreen);
      } else {
        Utils.toast("Image Not Saved", AppColors.negativeRed);
      }
    } catch (e) {
      Utils.toast(e.toString(), AppColors.negativeRed);
    } finally {
      downloadingStatus.value = false;
    }
  }
}
