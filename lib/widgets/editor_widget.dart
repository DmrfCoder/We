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
      if (editbean.istext) {
        TextEditingController textEditingController =
        new TextEditingController();
        textEditingController.text = editbean.text;

        children.add(
            new TextWidget(
                editbean.text, editbean.index, widget.editorControllor,
                widget.addprojectState)
        );
      } else {
        children.add(new ImageWidget('images/we_icon.png', editbean.index,
            widget.editorControllor, widget.addprojectState));
      }
    }

    return new Column(
      children: children,
    );
  }
}
