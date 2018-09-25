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

import 'dart:ui';
import 'package:flutter/material.dart';

class TimelinePainter extends CustomPainter {

  final Color lineColor;
  final Color backgroundColor;
  final bool firstElement;
  final bool lastElement;
  final Animation<double> controller;
  final Animation<double> height;

  TimelinePainter({
    @required this.lineColor,
    @required this.backgroundColor,
    this.firstElement = false,
    this.lastElement = false,
    this.controller
  }) :height = new Tween(begin: 0.0, end: 1.0).animate(new CurvedAnimation(
          parent: controller,
          curve: new Interval(
            0.45, 1.0,
            curve: Curves.ease),
        ),
      ),
      super(repaint: controller);

  @override
  void paint(Canvas canvas, Size size) {
    _centerElementPaint(canvas, size);
  }

  void _centerElementPaint(Canvas canvas, Size size)
  {
    Paint lineStroke = new Paint()
    ..color = lineColor
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 2.0
    ..style = PaintingStyle.stroke;
    if(firstElement && lastElement)
    {
      // Do nothing
    }
    else if(firstElement)
    {
      Offset offsetCenter = size.center(new Offset(0.0, -4.0));
      Offset offsetBottom = size.bottomCenter(new Offset(0.0, 0.0));
      Offset renderOffset = new Offset(offsetBottom.dx, offsetBottom.dy*(0.5+(controller.value/2)));
      canvas.drawLine(
      offsetCenter, 
      renderOffset, 
      lineStroke);
    }
    else if(lastElement)
    {
      Offset offsetTopCenter = size.topCenter(new Offset(0.0, 0.0));
      Offset offsetCenter = size.center(new Offset(0.0, -4.0));
      Offset renderOffset = new Offset(offsetCenter.dx, offsetCenter.dy*controller.value);
      canvas.drawLine(
      offsetTopCenter, 
      renderOffset, 
      lineStroke);
    }
    else {
      Offset offsetTopCenter = size.topCenter(new Offset(0.0, 0.0));
      Offset offsetBottom = size.bottomCenter(new Offset(0.0, 0.0));
      Offset renderOffset = new Offset(offsetBottom.dx, offsetBottom.dy*controller.value);
      canvas.drawLine(
      offsetTopCenter, 
      renderOffset, 
      lineStroke);
    }
    
    
    Paint circleFill = new Paint()
    ..color = lineColor
    ..style = PaintingStyle.fill;

    canvas.drawCircle(size.center(new Offset(0.0, -8.0)), 6.0, circleFill);

  }

  @override
  bool shouldRepaint(TimelinePainter oldDelegate) {
    return oldDelegate.lineColor!=lineColor || oldDelegate.backgroundColor!=backgroundColor;
  }

}