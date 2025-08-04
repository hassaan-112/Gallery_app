import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../model/localPicModel.dart';
import '../repository/imagesRepository.dart';
import '../res/colors/appColors.dart';
import '../utils/Utils.dart';

class HomeScreenViewModel extends GetxController {
  File? image = null;
  RxList images=[].obs;
  RxBool loading = false.obs;
  RxBool updater = false.obs;
  final _imgRepo = ImagesRepository();
  final localImages=<Local_Picture>[].obs;

  Future<void> getLocalImages() async {

    localImages.value=await _imgRepo.getImages();
    await toFileList();
    updater.value=!updater.value;
  }
  Future<void> toFileList() async {
    final tempDir = await getTemporaryDirectory();
    images.value=[];

    for(int i=0;i<localImages.length;i++){
      final file = File('${tempDir.path}/image$i.jpg');
      await file.writeAsBytes(localImages[i].image!);
      images.add(file);
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
  }
  void deleteAll(){
    _imgRepo.deleteAll();
    images.clear();
    localImages.clear();
    updater.value=!updater.value;
  }

}
