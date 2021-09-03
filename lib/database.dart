import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ImageDb {

  Database? _db;

  Future<Database> get database async {
    if (this._db != null) {
      return this._db as Database;
    } else {
      final dbPath = join(await getDatabasesPath(), 'database.db');
      final database = openDatabase(dbPath,
                                    version: 2,
                                    onCreate: (Database newDb, int version) {
                                      newDb.execute('''create table STATE_IMAGES ( state TEXT PRIMARY KEY, image BLOB)''');
                                    });
      return await database;
    }

  }


}