import 'package:gallery_saver_plus/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../data/response/status.dart';
import '../model/photosModel.dart';
import '../repository/searchRepository.dart';
import '../res/colors/appColors.dart';
import '../utils/Utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';

class SearchViewModel extends GetxController {
  RxInt selectedIndex = 0.obs;
  final status = Status.IDLE.obs;
  final _searchRepository = SearchRepository();
  final controller = TextEditingController().obs;
  final focusNode = FocusNode().obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxBool showOptions = true.obs;
  RxBool isSearch = false.obs;
  RxBool isLoading = false.obs;
  PictureClass? pictureClass;
  RxString error = "".obs;
  RxBool downloadingStatus = false.obs;

  void setStatus(Status status) => {this.status.value = status};
  void setSelectedIndex(int index) {
    selectedIndex.value = index;
  }

  Future<void> search() async {
    setStatus(Status.LOADING);
    _searchRepository
        .getPhotos(controller.value.text)
        .then((value) {
          setStatus(Status.COMPLETED);
          pictureClass = value;
        })
        .onError((error, stackTrace) {
          setStatus(Status.ERROR);
          Utils.toast(error.toString(), AppColors.negativeRed);
        });
  }

  void saveToGallery(String path) async {
    downloadingStatus.value = true;
    try {
      bool? success = await GallerySaver.saveImage(
        path,
        albumName: 'Gallery App',
      );
      if (success!) {
        Utils.toast("Image Saved", AppColors.positiveGreen);
        downloadingStatus.value = false;
      } else {
        Utils.toast("Image Not Saved", AppColors.negativeRed);
        downloadingStatus.value = false;
      }
    } catch (e) {
      Utils.toast(e.toString(), AppColors.negativeRed);
      downloadingStatus.value = false;
    }
  }

  void saveTonGallery(String pathh) async {
    downloadingStatus.value = true;
    try {
      final temp = await getTemporaryDirectory();
      var path = '${temp.path}/image.jpg';
      await Dio().download(pathh, path);
      bool? success = await GallerySaver.saveImage(
        path,
        albumName: 'Gallery App',
      );
      if (success!) {
        Utils.toast("Image Saved", AppColors.positiveGreen);
        downloadingStatus.value = false;
      } else {
        Utils.toast("Image Not Saved", AppColors.negativeRed);
      }
    } catch (e) {
      Utils.toast(e.toString(), AppColors.negativeRed);
      downloadingStatus.value = false;
    }
  }
}
