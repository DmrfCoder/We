import 'package:flutter_we/beans/event_bean.dart';

abstract class TimeLineModelEditCallBack {
  addTimelineModel(TimelineModel timelineModel);

  deleteTimelineModel(TimelineModel timelineModel);

  updateTimelineModel(TimelineModel timelineModel);
}
