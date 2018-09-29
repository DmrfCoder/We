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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _contentController = new TextEditingController();
    _contentController.text = widget.text;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new TextField(
      controller: _contentController,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
    );
  }
}
