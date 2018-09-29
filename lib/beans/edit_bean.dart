import 'dart:io';

import 'package:flutter/widgets.dart';

class EditBean {
  int index;
  bool istext;
  String text;
  File image;

  EditBean(this.index, this.istext, this.text, this.image);
}
