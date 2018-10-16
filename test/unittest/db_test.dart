import 'package:flutter_we/utils/db_util.dart';
import 'package:path/path.dart';
import 'package:test/test.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  test("insert data to db test", () async {
    int result = await DbUtil.insertDataToDb("test", "");


  });
}
