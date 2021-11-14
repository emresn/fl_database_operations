import 'package:fl_database_operations/core/init/database_init.dart';
import 'package:sqflite/sqflite.dart';

class DBHelpers {
  DatabaseInit instance = DatabaseInit.instance;
  String table = DatabaseInit.table;
  String columnId = DatabaseInit.columnId;

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.initializeDB();
    int id = await db.insert(table, row);
    db.close();
    return id;
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.initializeDB();
    List<Map<String, dynamic>> rows = await db.query(table);
    db.close();
    return rows;
  }

  Future<int> queryRowCount() async {
    Database db = await instance.initializeDB();
    List<Map<String, Object?>> queryResult =
        await db.rawQuery('SELECT COUNT(*) FROM $table');
    int result = Sqflite.firstIntValue(queryResult) ?? 0;
    db.close();

    return result;
  }

  Future<bool?> update(Map<String, dynamic> row) async {
    Database db = await instance.initializeDB();
    int id = row[columnId];
    await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
    db.close();
    return true;
  }

  Future<bool> delete(int id) async {
    Database db = await instance.initializeDB();
    await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
    db.close();
    return true;
  }
}
