import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_we/beans/edit_bean.dart';
import 'package:flutter_we/beans/edit_list_bean.dart';
import 'package:flutter_we/controllor/editor_controllor.dart';
import 'package:flutter_we/pages/addproject_page.dart';
import 'package:flutter_we/widgets/image_widget.dart';
import 'package:flutter_we/widgets/text_widget.dart';

class Editor extends StatefulWidget {
  EditorControllor editorControllor;
  AddprojectState addprojectState;

  @override
  State<StatefulWidget> createState() => new _EditorState();

  Editor(this.editorControllor, this.addprojectState);
}

class _EditorState extends State<Editor> {
  @override
  Widget build(BuildContext context) {
    EditbeanList _editbeanList = widget.editorControllor.editbeanList;
    List<EditBean> list = _editbeanList.list;

    final children = <Widget>[];

    for (EditBean editbean in list) {
      if (editbean.isText) {
        children.add(new TextWidget(editbean.content, editbean.index,
            widget.editorControllor, widget.addprojectState));
      } else {
        File imgFile;
        imgFile.writeAsStringSync(editbean.content, encoding: latin1);
        var image = new ImageWidget(imgFile, editbean.index,
            widget.editorControllor, widget.addprojectState);

        children.add(image);
      }
    }

    return new Column(
      children: children,
    );
  }
}
