import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../data/response/status.dart';
import '../model/photosModel.dart';
import '../repository/searchRepository.dart';
import '../res/colors/appColors.dart';
import '../utils/Utils.dart';



class SearchViewModel extends GetxController {
  RxInt selectedIndex = 0.obs;
  final status =Status.IDLE.obs;
  final _searchRepository = SearchRepository();
  final controller = TextEditingController().obs;
  final focusNode = FocusNode().obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxBool showOptions = true.obs;
  RxBool isSearch = false.obs;
  RxBool isLoading = false.obs;
  PictureClass? pictureClass;
  RxString error="".obs;

  void setStatus(Status status)=>{this.status.value=status};
  void setSelectedIndex(int index) {selectedIndex.value = index;}

  Future<void> search() async {
    setStatus(Status.LOADING);
    _searchRepository
        .getPhotos(controller.value.text)
        .then((value) {
          setStatus(Status.COMPLETED);
          pictureClass=value;
    })
        .onError((error, stackTrace) {
          setStatus(Status.ERROR);
          Utils.toast(error.toString(), AppColors.negativeRed);
    });
  }
}