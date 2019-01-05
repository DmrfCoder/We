import 'package:flutter_calendar_carousel/classes/event.dart';

abstract class AddToDoWorkCallBack {
  addSuccess(String content);
}

abstract class AddToDoEventCallBack {
  addEventSuccess(Event event);
}
