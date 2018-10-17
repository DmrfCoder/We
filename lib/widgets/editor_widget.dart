import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_we/beans/constant_bean.dart';
import 'package:flutter_we/beans/edit_bean.dart';
import 'package:flutter_we/beans/edit_list_bean.dart';
import 'package:flutter_we/callback/addprojet_callback.dart';
import 'package:flutter_we/callback/editor_callback.dart';
import 'package:flutter_we/controllor/editor_controllor.dart';
import 'package:flutter_we/pages/addproject_page.dart';
import 'package:flutter_we/widgets/image_widget.dart';
import 'package:flutter_we/widgets/text_widget.dart';

class Editor extends StatefulWidget {
  final AddProjectPageCallBack addProjectPageCallBack;

  final List<EditBean> list;

  @override
  State<StatefulWidget> createState() => new _EditorState();

  Editor({Key key, this.addProjectPageCallBack, this.list}) : super(key: key);
}

class _EditorState extends State<Editor> implements EditorCallBack {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];

    bool findFirstText = false;
    for (int i = widget.list.length - 1; i >= 0; i--) {
      EditBean editbean = widget.list[i];

      if (editbean.isText) {

        children.insert(
            0,
            new TextWidget(
              editBean: editbean,
              editorCallBack: this,
              autoFoucus: !findFirstText,
            ));

        if (!findFirstText) {
          findFirstText = true;
        }
      } else {
        var image = new ImageWidget(
          editBean: editbean,
          editorCallBack: this,
        );
        children.insert(0, image);
      }
    }

    return new Column(
      children: children,
    );
  }

  @override
  void didUpdateWidget(Editor oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    //widget.editorControllor.onSave();
  }

  @override
  updateEditBeanData({ChangeType changeType, EditBean editBean}) {
    // TODO: implement updateEditBeanData
    switch (changeType) {
      case ChangeType.delete:
        widget.addProjectPageCallBack.deleteEditbean(editBean);
        break;
      case ChangeType.update:
        widget.addProjectPageCallBack.updateEditbean(editBean);
        break;
    }
  }

  @override
  updateCurIndex({EditBean CurEditBean}) {
    // TODO: implement updateCurIndex
    widget.addProjectPageCallBack.updateCurEditbean(CurEditBean);
  }
}
