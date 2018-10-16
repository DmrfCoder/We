import 'dart:convert';

import 'package:flutter_we/beans/constant_bean.dart';
import 'package:flutter_we/beans/edit_list_bean.dart';
import 'package:flutter_we/beans/event_bean.dart';
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

  static insertDataToDb(String dbName, TimelineModel timelineModel) async {
    Database database = await openDb(dbName);
    int result = 0;
    try {
      result = await database.insert("MessageData", {
        "messageType": timelineModel.messageType == MessageType.nice ? 0 : 1,
        "isDeleted": 0,
        "createdTime": timelineModel.time,
        "content": json.encode(timelineModel.editbeanList)
      });
    } on DatabaseException catch (e) {
      print(e.toString());
      result = -1;
    }

    database.close();
    return result;
  }

  static queryDataDb(String dbName) async {
    Database database = await openDb(dbName);
    int result = 0;
    List<TimelineModel> timeLineModelList = [];
    try {
      List<Map<String, dynamic>> dbData = await database.query("MessageData");

      for (Map<String, dynamic> mapItem in dbData) {
        TimelineModel timelineModel = new TimelineModel();
        int messageType = mapItem["messageType"];

        timelineModel.messageType =
            messageType == 0 ? MessageType.nice : MessageType.bad;
        timelineModel.id = mapItem["id"].toString();

        Map timelineModelMap = json.decode(mapItem["content"]);
        timelineModel.editbeanList =
            new EditbeanList.fromJson(timelineModelMap);

        timelineModel.time = mapItem["createdTime"];

        timeLineModelList.insert(0,timelineModel);
      }

      result = 1;
    } on DatabaseException catch (e) {
      print(e.toString());
      result = -1;
    }

    return {"result": result, "timeLineModelList": timeLineModelList};
  }

  static deleteDataDb(String dbName, int id) async {
    Database database = await openDb(dbName);
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

  static updateDataDb(String dbName, int id, EditbeanList data) async {
    Database database = await openDb(dbName);
    int result = 0;
    try {
      result = await database.update(
          "MessageData", {"content": json.encode(data)},
          where: '"id" = ?', whereArgs: ["$id"]);
    } on DatabaseException catch (e) {
      print(e.toString());
      result = -1;
    }

    return result;
  }
}
