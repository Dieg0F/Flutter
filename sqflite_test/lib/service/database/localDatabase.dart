import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  void createDatabase() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = databasesPath + 'demo.db';

    // open the database
    await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)');
    });
  }

  void insertValues() async {
    var db = await openDatabase('demo.db');

    // Insert some records in a transaction
    await db.transaction((txn) async {
      int id1 = await txn.rawInsert(
          'INSERT INTO Test(name, value, num) VALUES("some name", 1234, 456.789)');
      print('inserted1: $id1');
      int id2 = await txn.rawInsert(
          'INSERT INTO Test(name, value, num) VALUES(?, ?, ?)',
          ['another name', 12345678, 3.1416]);
      print('inserted2: $id2');
    });
  }

  void updateValues() async {
    var db = await openDatabase('demo.db');

    // Update some record
    int count = await db.rawUpdate(
        'UPDATE Test SET name = ?, VALUE = ? WHERE name = ?',
        ['updated name', '9876', 'some name']);
    print('updated: $count');
  }

  void selectValues() async {
    var db = await openDatabase('demo.db');

    // Get the records
    List<Map> list = await db.rawQuery('SELECT * FROM Test');
    List<Map> expectedList = [
      {'name': 'updated name', 'id': 1, 'value': 9876, 'num': 456.789},
      {'name': 'another name', 'id': 2, 'value': 12345678, 'num': 3.1416}
    ];
    print(list);
    print(expectedList);
  }

  void deleteValues() async {
    var db = await openDatabase('demo.db');

    // Delete a record
    await db.rawDelete('DELETE FROM Test WHERE name = ?', ['another name']);
  }
}
