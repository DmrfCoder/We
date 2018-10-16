import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbUtil {
  static openDb(String dbName) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, "$dbName.db");

    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          "CREATE TABLE MessageData (id INTEGER PRIMARY KEY, messageType INTEGER, isDeleted INTEGER, createdTime TEXT,content TEXT)");
    });

    return database;
  }

  static insertDataToDb(String dbName, var data) async {
    Database database = await openDb("demo");
    int result = 0;
    try {
      result = await database.insert("MessageData", {
        "messageType": 0,
        "isDeleted": 0,
        "createdTime": "2018-9-9 10:00",
        "content": "test content"
      });
    } on DatabaseException catch (e) {
      print(e.toString());
      result = -1;
    }

    database.close();
    return result;
  }

  static queryDataDb() async {
    Database database = await openDb("demo");
    int result = 0;
    try {
      var dbData = await database.query("MessageData");
      print(dbData.toString());
      result = 1;
    } on DatabaseException catch (e) {
      print(e.toString());
      result = -1;
    }

    return result;
  }

  static deleteDataDb(int id) async {
    Database database = await openDb("demo");
    int result = 0;
    try {
      result = await database
          .delete("MessageData", where: '"id" = ?', whereArgs: ["$id"]);
    } on DatabaseException catch (e) {
      print(e.toString());
      result = -1;
    }

    return result;
  }

  static updateDataDb(int id, var data) async {
    Database database = await openDb("demo");
    int result = 0;
    try {
      result = await database.update("MessageData", {"messageType": 1},
          where: '"id" = ?', whereArgs: ["$id"]);
    } on DatabaseException catch (e) {
      print(e.toString());
      result = -1;
    }

    return result;
  }
}
