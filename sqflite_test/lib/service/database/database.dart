import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_test/model/client/client.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + "TestDB.db";
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute();
    });
  }

  insert(String query) async {
    final db = await database;
    var res = await db.rawInsert(query);
    return res;
  }

  select(String query) async {
    final db = await database;
    var res = await db.query(query);
    List<Client> list =
        res.isNotEmpty ? res.map((c) => Client.fromJson(c)).toList() : [];
    return list;
  }

  update(String table, Map<String, dynamic> objJson,
      {String whereClause = "", String whereArgs = ""}) async {
    final db = await database;
    var res = await db
        .update(table, objJson, where: whereClause, whereArgs: [whereArgs]);
    return res;
  }

  delete(String table, {String whereClause = "", String whereArgs = ""}) async {
    final db = await database;
    db.delete(table, where: "whereClause", whereArgs: [whereArgs]);
  }




  newClient(Client newClient) async {
    final db = await database;
    var res = await db.rawInsert("INSERT Into Client (id,first_name)"
        " VALUES (${newClient.id},${newClient.firstName})");
    return res;
  }

  getClient(int id) async {
    final db = await database;
    var res = await db.query("Client", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Client.fromJson(res.first) : Null;
  }

  getAllClients() async {
    final db = await database;
    var res = await db.query("Client");
    List<Client> list =
        res.isNotEmpty ? res.map((c) => Client.fromJson(c)).toList() : [];
    return list;
  }

  updateClient(Client newClient) async {
    final db = await database;
    var res = await db.update("Client", newClient.toJson(),
        where: "id = ?", whereArgs: [newClient.id]);
    return res;
  }

  deleteClient(int id) async {
    final db = await database;
    db.delete("Client", where: "id = ?", whereArgs: [id]);
  }
}
