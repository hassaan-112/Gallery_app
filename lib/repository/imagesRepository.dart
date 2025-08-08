import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:gallery_app/database/database.dart';
import 'package:gallery_app/model/localPicModel.dart';
import 'package:get/get.dart';

import '../database/dao.dart';
import '../res/colors/appColors.dart';
import '../utils/Utils.dart';

class ImagesRepository {
  final _dao = Dao.dao;

  static const int maxSizeKB = 500;

  Future<void> addImage(File image, String title, String description) async {
    Uint8List imageBytes = image.readAsBytesSync();
    int imageSizeKB = imageBytes.lengthInBytes ~/ 1024;

    if (imageSizeKB > maxSizeKB) {
      Uint8List? compressedBytes = await FlutterImageCompress.compressWithFile(
        image.absolute.path,
        quality: 50,
        format: CompressFormat.jpeg,
      );

      if (compressedBytes == null) {
        Utils.toast("compression_failed".tr, AppColors.negativeRed);
        return;
      }

      int compressedSizeKB = compressedBytes.lengthInBytes ~/ 1024;

      if (compressedSizeKB > maxSizeKB) {
        //compressing again
        compressedBytes = await FlutterImageCompress.compressWithFile(
          image.absolute.path,
          quality: 50,
          format: CompressFormat.jpeg,
        );
        if (compressedBytes == null) {
          Utils.toast("compression_failed".tr, AppColors.negativeRed);
          return;
        }
        compressedSizeKB = compressedBytes.lengthInBytes ~/ 1024;
        if (compressedSizeKB > maxSizeKB) {
          Utils.toast("image_too_large".tr, AppColors.negativeRed);
          return;
        }
        return;
      }

      // Save compressed image
      bool res = await _dao.addImage(compressedBytes, title, description);
      _handleResult(res);
    } else {
      //Save original image
      bool res = await _dao.addImage(imageBytes, title, description);
      _handleResult(res);
    }
  }

  void _handleResult(bool success) {
    if (success) {
      Utils.toast("image_added".tr, AppColors.positiveGreen);
    } else {
      Utils.toast("image_not_added".tr, AppColors.negativeRed);
    }
  }

  Future<List<Local_Picture>> getImages() async {
    var result = await _dao.getImages();
    List<Local_Picture> images = result.map((e) => Local_Picture.fromMap(e)).toList();
    return images;
  }

  Future<bool> deleteImage(int id) async {
    return await _dao.deleteImage(id);
  }

  Future<bool> deleteAll() async {
    return await _dao.deleteAll();
  }
}
