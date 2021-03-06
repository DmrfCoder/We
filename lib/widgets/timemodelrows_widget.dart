import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_we/beans/constant_bean.dart';
import 'package:flutter_we/beans/edit_bean.dart';
import 'package:flutter_we/beans/event_bean.dart';
import 'package:flutter_we/callback/listview_item_click_callback.dart';

class TimeModelRow extends StatefulWidget {
  final double dotSize = 40.0;

  final TimelineModel model;

  final LocationType locationType;

  final ListviewItemClickCallBack listviewItemClickCallBack;

  const TimeModelRow(
      {Key key, this.model, this.listviewItemClickCallBack, this.locationType})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new TimeLineModelState();
  }
}

class TimeLineModelState extends State<TimeModelRow> {
  Widget _buildContentColumnTime(BuildContext context) {
    return new Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Container(
          child: new Text(
            widget.model.time,
            style: new TextStyle(
              //background: paint,
              color: Colors.black,
              fontSize: 15.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildContentColumn(BuildContext context) {
    String content = "";

    for (EditBean item in widget.model.editbeanList.list) {
      if (item.isText) {
        content = item.content;
        break;
      }
    }

    return new Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Container(
          child: new Text(
            content,
            overflow: TextOverflow.ellipsis,
            maxLines: 4,
            style: new TextStyle(
                //background: paint,
                color: Colors.black,
                fontSize: 15.0),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeline() {
    return new Positioned(
      top: 0.0,
      bottom: 0.0,
      left: MediaQuery.of(context).size.width / 2,
      child: new Container(
        width: 2.0,
        color: Colors.red[300],
      ),
    );
  }

  double center_x = 0.0;

  @override
  Widget build(BuildContext context) {
    center_x = MediaQuery.of(context).size.width / 2;
    // TODO: implement build
    return new InkWell(
      onTap: () => widget.listviewItemClickCallBack.onTap(widget.model.id),
      onLongPress: () =>
          widget.listviewItemClickCallBack.onLongPress(widget.model.id),
      child: new Container(
        height: 80.0,
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Expanded(
              child: _buildContentColumnTime(context),
            ),
            new Padding(
              padding: new EdgeInsets.symmetric(
                  horizontal: 32.0 - widget.dotSize / 2),
              child: new Container(
                width: widget.dotSize,
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: getPositionImage(),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
            new Expanded(
              child: _buildContentColumn(context),
            ),
          ],
        ),
      ),
    );
  }

  getPositionImage() {
    if (widget.model.isOther) {
      switch (widget.locationType) {
        case LocationType.center:
          return new ExactAssetImage('images/other_center.png');
        case LocationType.alone:
          return new ExactAssetImage('images/other_alone.png');
        case LocationType.bottom:
          return new ExactAssetImage('images/other_bottom.png');
        case LocationType.top:
          return new ExactAssetImage('images/other_top.png');
        default:
          return new ExactAssetImage('images/other_alone.png');
      }
    } else {
      if (widget.model.messageType == MessageType.bad) {
        switch (widget.locationType) {
          case LocationType.center:
            return new ExactAssetImage('images/black_heart_center.png');
          case LocationType.alone:
            return new ExactAssetImage('images/black_heart_alone.png');
          case LocationType.bottom:
            return new ExactAssetImage('images/black_heart_bottom.png');
          case LocationType.top:
            return new ExactAssetImage('images/black_heart_top.png');
          default:
            return new ExactAssetImage('images/black_heart_alone.png');
        }
      } else {
        switch (widget.locationType) {
          case LocationType.center:
            return new ExactAssetImage('images/heart_center.png');
          case LocationType.alone:
            return new ExactAssetImage('images/heart_alone.png');
          case LocationType.bottom:
            return new ExactAssetImage('images/heart_bottom.png');
          case LocationType.top:
            return new ExactAssetImage('images/heart_top.png');
          default:
            return new ExactAssetImage('images/heart_alone.png');
        }
      }
    }
  }
}
