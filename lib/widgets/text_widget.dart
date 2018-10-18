import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_we/beans/constant_bean.dart';
import 'package:flutter_we/beans/edit_bean.dart';
import 'package:flutter_we/callback/editor_callback.dart';
import 'package:flutter_we/controllor/editor_controllor.dart';
import 'package:flutter_we/controllor/text_controllor.dart';
import 'package:flutter_we/pages/addproject_page.dart';
import 'package:flutter_we/widgets/editor_widget.dart';

class TextWidget extends StatefulWidget {
  EditBean editBean;

  final EditorCallBack editorCallBack;

  bool autoFoucus = false;

  @override
  State<StatefulWidget> createState() => new _TextWidgetState();

  TextWidget(
      {Key key, this.editBean, this.editorCallBack, this.autoFoucus = false})
      : super(key: key);
}

class _TextWidgetState extends State<TextWidget> {
  TextEditingController _contentController;

  FocusNode _focusNode = new FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _contentController = new TextEditingController();
    _contentController.text = widget.editBean.content;
    _focusNode.addListener(_focusNodelistener);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.editBean.content = _contentController.text;

    widget.editorCallBack.updateEditBeanData(
        changeType: ChangeType.update, editBean: widget.editBean);

    _focusNode.removeListener(_focusNodelistener);
  }

  Future<Null> _focusNodelistener() async {
    if (_focusNode.hasFocus) {
      widget.editorCallBack.updateCurIndex(CurEditBean: widget.editBean);
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
              fontSize: 20.0,
              color: Colors.black87,
            ),
            onChanged: _textChanged,
            autofocus: widget.autoFoucus,
            keyboardType: TextInputType.text,
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

  @override
  void didUpdateWidget(TextWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  void _textChanged(String value) {
    widget.editBean.content = value;

    widget.editorCallBack.updateEditBeanData(
        changeType: ChangeType.update, editBean: widget.editBean);
  }
}
