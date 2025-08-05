import 'dart:io';

import 'package:gallery_app/database/database.dart';
import 'package:gallery_app/model/localPicModel.dart';
import 'package:get/get.dart';

import '../res/colors/appColors.dart';
import '../utils/Utils.dart';

class ImagesRepository{

  final _db =DBHelper.getInstance;

  Future<void> addImage(File image,String title,String description) async {
    bool res = await _db.addImage(image.readAsBytesSync(),title,description);
    if (res) {
      Utils.toast("image_added".tr, AppColors.positiveGreen);
    }
    else {
      Utils.toast("image_not_added".tr, AppColors.negativeRed);
    }


  }
  Future<List<Local_Picture>> getImages() async {
    var result = await _db.getImages();
    List<Local_Picture> images = result.map((e) => Local_Picture.fromMap(e)).toList();
    return images;
  }
  Future<bool> deleteImage(int id) async {
    return await _db.deleteImage(id);
  }
  Future<bool> deleteAll() async {
    return await _db.deleteAll();
  }



}