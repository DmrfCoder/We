import 'dart:io';

import 'package:flutter/widgets.dart';

class EditBean {
  int index;
  bool isText;
  String content;

  EditBean(this.index, this.isText, this.content);

  updateIndex() {
    index++;
  }
}
