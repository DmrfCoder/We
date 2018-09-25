import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileIo {
  static final mFile = null;

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return new File('$path/nameFile.txt',);
  }

  static Future<File> save(String name) async {
    final file = await _localFile;
    return file.writeAsString(name);
  }

  static Future<String> get() async {
    final file = await _localFile;
    return file.readAsString();
  }
}
