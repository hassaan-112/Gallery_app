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
}