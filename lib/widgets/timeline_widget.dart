/* Copyright 2018 Rejish Radhakrishnan

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License. */

library timeline;

import 'package:flutter/material.dart';
import 'package:flutter_we/beans/constant_bean.dart';
import 'package:flutter_we/beans/event_bean.dart';
import 'package:flutter_we/callback/listview_item_click_callback.dart';
import 'package:flutter_we/widgets/timemodelrows_widget.dart';

class TimelineComponent extends StatefulWidget {
  final List<TimelineModel> timelineList;

  final Color lineColor;

  final Color backgroundColor;

  final Color headingColor;

  final Color descriptionColor;

  final ListviewItemClickCallBack listviewItemClickCallBack;

  const TimelineComponent(
      {Key key,
      this.timelineList,
      this.lineColor,
      this.backgroundColor,
      this.headingColor,
      this.descriptionColor,
      this.listviewItemClickCallBack})
      : super(key: key);

  @override
  TimelineComponentState createState() {
    return new TimelineComponentState();
  }
}

class TimelineComponentState extends State<TimelineComponent>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  double fraction = 0.0;


  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> child = [];

    int size = widget.timelineList.length;

    if (size == 1) {
      TimeModelRow timeModelRow = new TimeModelRow(
        model: widget.timelineList[0],
        listviewItemClickCallBack: widget.listviewItemClickCallBack,
        locationType: LocationType.alone,
      );
      child.add(timeModelRow);
    } else if (size > 1) {
      TimeModelRow timeModelRow = new TimeModelRow(
        model: widget.timelineList[0],
        listviewItemClickCallBack: widget.listviewItemClickCallBack,
        locationType: LocationType.top,
      );
      child.add(timeModelRow);

      TimeModelRow timeModelRow2 = new TimeModelRow(
        model: widget.timelineList[size - 1],
        listviewItemClickCallBack: widget.listviewItemClickCallBack,
        locationType: LocationType.bottom,
      );

      for (int i = 1; i < size - 2; i++) {
        TimeModelRow timeModelRow3 = new TimeModelRow(
          model: widget.timelineList[i],
          listviewItemClickCallBack: widget.listviewItemClickCallBack,
          locationType: LocationType.center,
        );
        child.add(timeModelRow3);
      }
      child.add(timeModelRow2);

    }


    return new Expanded(
      child: new ListView(

        children: child,

      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
