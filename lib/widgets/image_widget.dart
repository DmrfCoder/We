import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_we/beans/constant_bean.dart';
import 'package:flutter_we/beans/edit_bean.dart';
import 'package:flutter_we/callback/editor_callback.dart';
import 'package:flutter_we/controllor/editor_controllor.dart';
import 'package:flutter_we/pages/addproject_page.dart';
import 'package:path_provider/path_provider.dart';

class ImageWidget extends StatefulWidget {
  EditBean editBean;

  final EditorCallBack editorCallBack;

  ImageWidget({Key key, this.editBean, this.editorCallBack}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new ImageWidgetState();
}

class ImageWidgetState extends State<ImageWidget> {
  TextEditingController _imageNoteTextfiledController =
      new TextEditingController(text: '\n');

  var imageByte;

  bool IsNormalMode = true;

  Future initFile() async {
    print("initFile");
    imageByte = base64Decode(widget.editBean.content);
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
          child: _buildImage(),
          flex: 8,
        ),
        Expanded(
          child: new Text(""),
          flex: 1,
        ),
      ],
    );
  }

  _buildImage() {
    if (IsNormalMode) {
      return new GestureDetector(
        child: new Container(
          padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
            child: new Image.memory(imageByte)),
        onTap: () {
          setState(() {
            IsNormalMode = false;
          });
        },
      );
    } else {
      return new Stack(
        children: <Widget>[
          new Opacity(
            opacity: 0.2,
            child: new Image.memory(imageByte),
          ),
          new Row(
            children: <Widget>[
              new IconButton(
                  padding: EdgeInsets.all(0.0),
                  icon: new Icon(Icons.cancel),
                  color: Colors.green,
                  onPressed: () {
                    setState(() {
                      IsNormalMode = true;
                    });
                  }),
              new IconButton(
                  padding: EdgeInsets.all(0.0),
                  icon: new Icon(Icons.delete),
                  color: Colors.red,
                  onPressed: () {
                    clickImage();
                  }),
            ],
          ),
        ],
      );
    }
  }

  void clickImage() {
    print("be click");

    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return new CupertinoAlertDialog(
            title: new Text("确认删除该图片？"),
            actions: <Widget>[
              new CupertinoDialogAction(
                child: const Text('确定'),
                onPressed: () {
                  widget.editorCallBack.updateEditBeanData(
                      changeType: ChangeType.delete, editBean: widget.editBean);

                  Navigator.pop(context);
                },
              ),
              new CupertinoDialogAction(
                child: const Text('取消'),
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    IsNormalMode = true;
                  });
                },
              ),
            ],
          );
        });
  }
}
