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
        version: 4,
        onCreate: (db, version) async {
          await db.execute(
              '''
          CREATE TABLE images(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            image BLOB,
            title TEXT,
            description TEXT,
            datetime TEXT
          )
          '''
          );
        },
        onUpgrade: (db, oldVersion, newVersion) async {
          await db.execute('DROP TABLE IF EXISTS images');
          await db.execute(
              '''
          CREATE TABLE images(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            image BLOB,
            title TEXT,
            description TEXT,
            datetime TEXT
          )
          '''
          );
        }
    );
  }

  // Add image
  Future<bool> addImage(Uint8List image, String title, String description) async {
    try {
      Database db = await getDB();
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
      Database db = await getDB();
      return await db.query('images');
    } catch (e) {
      return [];
    }
  }

  // Delete image by ID
  Future<bool> deleteImage(int id) async {
    try {
      Database db = await getDB();
      await db.delete('images', where: 'id = ?', whereArgs: [id]);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Delete all images
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
