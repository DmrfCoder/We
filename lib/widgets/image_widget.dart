import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_we/controllor/editor_controllor.dart';
import 'package:flutter_we/pages/addproject_page.dart';

class ImageWidget extends StatefulWidget {
  File fileImage;
  int index;

  EditorControllor editorControllor;

  AddprojectState addprojectState;

  ImageWidget(
      this.fileImage, this.index, this.editorControllor, this.addprojectState);

  @override
  State<StatefulWidget> createState() => new ImageWidgetState();
}

class ImageWidgetState extends State<ImageWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void updateData() {
    widget.addprojectState.updateData();
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
            child: new Image.file(widget.fileImage),
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
                  widget.editorControllor.deleteIndex(widget.index, this);

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
