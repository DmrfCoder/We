import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_we/controllor/editor_controllor.dart';
import 'package:flutter_we/pages/addproject_page.dart';

class TextWidget extends StatefulWidget {
  String text;
  int index;

  TextWidget(
      this.text, this.index, this.editorControllor, this.addprojectState);

  EditorControllor editorControllor;

  AddprojectState addprojectState;

  @override
  State<StatefulWidget> createState() => new _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  TextEditingController _contentController;

  FocusNode _focusNode = new FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _contentController = new TextEditingController();
    _contentController.text = widget.text;
    _focusNode.addListener(_focusNodelistener);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _focusNode.removeListener(_focusNodelistener);
  }

  void updateData() {
    widget.addprojectState.updateData();
  }

  Future<Null> _focusNodelistener() async {
    if (_focusNode.hasFocus) {
      widget.editorControllor.curIndex = widget.index;
    } else {
      if (_contentController.text.isEmpty) {
        widget.editorControllor.deleteIndex(widget.index, this);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Row(
      children: <Widget>[
        Expanded(
          child: new Text(""),
          flex: 1,
        ),
        Expanded(
          child: new TextField(
            controller: _contentController,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
            maxLines: null,
            style: new TextStyle(
              fontSize: 30.0,
              color: Colors.black87,
            ),
          ),
          flex: 18,

        ),
        Expanded(
          child: new Text(""),
          flex: 1,
        ),
      ],
    );
  }
}
