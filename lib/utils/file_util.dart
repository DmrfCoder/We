import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileIo {
  static final mFile = null;

  static String localPath = "";

  static FileIo _fileio;

  static FileIo getInstance() {
    if (_fileio == null) {
      _fileio = new FileIo();
    }
    return _fileio;
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> getlocalFile({String filename = "data.txt"}) async {
    if (localPath=="") {
      localPath = await  _localPath;
    }


    File file = new File(
      '$localPath/$filename',
    );

    return file;
  }

  Future<File> save(String content, {String filename = "data.txt"}) async {
    final file = await getlocalFile(filename: filename);

    return file.writeAsString(content);
  }

  Future<String> get({String filename = "data.txt"}) async {
    final file = await getlocalFile(filename: filename);
    return file.readAsString();
  }
}
