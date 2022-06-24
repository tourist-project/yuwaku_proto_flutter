import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async' as asyncio ;

/// 参考にした記事: https://kehalife.com/flutter-sqflite/
// TODO: DB作れるか確認

class ImageDBProvider {

  final _databaseName = "yuwaku_database.db";
  final _databaseVersion = 1;

  final tableName = 'image_table';

  ImageDBProvider._privateConstructor();
  static final ImageDBProvider instance = ImageDBProvider._privateConstructor();

  static Database? _database;
  asyncio.Future<Database> get database async {
    if (_database != null) return _database as Database;
    _database = await _initDatabase();
    return _database as Database;
  }

  void _createTableV1(Batch batch) {
    batch.execute('''
    CREATE TABLE $tableName(
      state TEXT NOT NULL UNIQUE,
      image TEXT
    );
    ''');
  }

  _initDatabase() async {
    final Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: (db, version) async {
        var batch = db.batch();
        _createTableV1(batch);
        await batch.commit();
      },
      onDowngrade: onDatabaseDowngradeDelete,
    );
  }

  // 挿入
  asyncio.Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database; //DBにアクセスする
    return await db.insert(tableName, row); //テーブルにマップ型のものを挿入。追加時のrowIDを返り値にする
  }

  // 全件取得
  asyncio.Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database; //DBにアクセスする
    return await db.query(tableName); //全件取得
  }

  asyncio.Future<List<Map<String, Object?>>> querySearchRows(state) async {
    Database db = await instance.database; //DBにアクセスする
    return await db.rawQuery('SELECT * FROM $tableName WHERE state=?', [state]);
  }

  // データ件数取得
  asyncio.Future<int?> queryRowCount() async {
    Database db = await instance.database; //DBにアクセスする
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $tableName'));
  }

  asyncio.Future<bool> isExist(String state) async {
    Database db = await instance.database;
    int count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $tableName WHERE state=?', [state]))!;
    return count > 0;
  }

  Future updateImage(String state, String image) async {
    Database db = await instance.database; //DBにアクセスする
    return await db.rawQuery('UPDATE $tableName SET image=? WHERE state=?', [image, state]);
  }

  Future<int> countImage() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(image) FROM $tableName'))!;
  }

  Future deleteAll() async {
    Database db = await instance.database;
    return await db.rawQuery('DELETE FROM $tableName');
  }


}