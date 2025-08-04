import 'dart:io';

import 'package:gallery_app/database/database.dart';
import 'package:gallery_app/model/localPicModel.dart';

class ImagesRepository{

  final _db =DBHelper.getInstance;

  Future<void> addImage(File image) async {
    _db.addImage(image.readAsBytesSync());
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