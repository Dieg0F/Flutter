import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB("CREATE TABLE Breed (" +
        "id INTEGER PRIMARY KEY AUTOINCREMENT," +
        "name TEXT," +
        "about TEXT," +
        "registered DATETIME," +
        "size INTEGER," +
        "weight INTEGER," +
        "picture TEXT," +
        "isActive BIT" +
        ")");
    return _database;
  }

  initDB(String table) async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + "TestDB.db";
    return await openDatabase(path, version: 4, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(table);
    });
  }

  insert(String query) async {
    final db = await database;
    var res = await db.rawInsert(query);
    print(res);
    return res;
  }

  select(String query) async {
    final db = await database;
    var res = await db.query("Breed");
    return res;
  }

  update(String query) async {
    final db = await database;
    var res = await db.rawUpdate(query);
    return res;
  }

  delete(String query) async {
    final db = await database;
    var res = await db.rawDelete(query);
    return res;
  }  

}
