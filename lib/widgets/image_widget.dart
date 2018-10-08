import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_we/beans/constant_bean.dart';
import 'package:flutter_we/beans/edit_bean.dart';
import 'package:flutter_we/callback/editor_callback.dart';
import 'package:flutter_we/controllor/editor_controllor.dart';
import 'package:flutter_we/pages/addproject_page.dart';
import 'package:flutter_we/utils/file_util.dart';
import 'package:path_provider/path_provider.dart';

class ImageWidget extends StatefulWidget {
  EditBean editBean;

  final EditorCallBack editorCallBack;

  ImageWidget({Key key, this.editBean, this.editorCallBack}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new ImageWidgetState();
}

class ImageWidgetState extends State<ImageWidget> {
  File file;

  Future initFile() async {
    print("initFile");
//    file = await FileIo.getTempFile();
//    file.writeAsStringSync(widget.editBean.content, encoding: latin1);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initFile();


  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        Expanded(
          child: new Text(""),
          flex: 1,
        ),
        Expanded(
          child: new GestureDetector(
            child: new Image.file(file),
            onTap: clickImage,
          ),
          flex: 8,
        ),
        Expanded(
          child: new Text(""),
          flex: 1,
        ),
      ],
    );
  }

  void clickImage() {
    print("be click");

    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return new SimpleDialog(
            title: new Text("确认删除该图片？"),
            children: <Widget>[
              new SimpleDialogOption(
                onPressed: () {
                  widget.editorCallBack.updateEditBeanData(
                      changeType: ChangeType.delete, editBean: widget.editBean);

                  Navigator.pop(context);
                },
                child: const Text('确定'),
              ),
              new SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('取消'),
              ),
            ],
          );
        });
  }
}
