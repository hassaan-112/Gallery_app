import 'dart:typed_data';

import 'package:sqflite/sqflite.dart';

import 'database.dart';
class Dao {
  Dao._();
  static final Dao dao = Dao._();

  final _db = DBHelper.getInstance;

  // Add image
  Future<bool> addImage(Uint8List image, String title, String description) async {
    try {
      Database db = await _db.getDB();
      String fullDateTime = DateTime.now().toIso8601String();
      await db.insert('images', {
        'image': image,
        'title': title,
        'description': description,
        'datetime': fullDateTime,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  // Get all images
  Future<List<Map<String, dynamic>>> getImages() async {
    try {
      Database db = await _db.getDB();
      return await db.query('images');
    } catch (e) {
      return [];
    }
  }

  // Delete image by ID
  Future<bool> deleteImage(int id) async {
    try {
      Database db = await _db.getDB();
      await db.delete('images', where: 'id = ?', whereArgs: [id]);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Delete all images
  Future<bool> deleteAll() async {
    try {
      Database db = await _db.getDB();
      await db.delete('images');
      return true;
    } catch (e) {
      return false;
    }
  }

}