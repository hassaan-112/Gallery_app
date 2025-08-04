import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._();

  static final DBHelper getInstance = DBHelper._();

  Database? myDB;

  Future<Database> getDB() async {
    myDB ??= await openDB();
    return myDB!;
  }

  Future<Database> openDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String dbPath = join(directory.path, 'users.db');
    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE images(id INTEGER PRIMARY KEY AUTOINCREMENT,image BLOB)',
        );
      },
    );
  }

  //add images
  Future<bool> addImage(Uint8List image) async {
    try {
      Database db = await getDB();
      await db.insert('images', {'image': image});
      return true;
    } catch (e) {
      return false;
    }
  }

  // get images
  Future<List<Map<String, dynamic>>> getImages() async {
    try {
      Database db = await getDB();
      List<Map<String, dynamic>> images = await db.query('images');
      return images;
    } catch (e) {
      return [];
    }
  }

  Future<bool> deleteImage(int id) async {
    try {
      Database db = await getDB();
      await db.delete('images', where: 'id = ?', whereArgs: [id]);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteAll() async {
    try {
      Database db = await getDB();
      await db.delete('images');
      return true;
    } catch (e) {
      return false;
    }
  }
}
