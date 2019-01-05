import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_we/beans/todo_work_bean.dart';
import 'package:flutter_we/callback/add_todo_work_callback.dart';
import 'package:flutter_we/pages/manage_todo_work_page.dart';
import 'package:flutter_we/utils/http_util.dart';
import 'package:intl/intl.dart';

class ToDoWorkPage extends StatefulWidget {
  String userId;

  ToDoWorkPage(this.userId);

  @override
  State<StatefulWidget> createState() => new ToDoWorkState();
}

class ToDoWorkState extends State<ToDoWorkPage>
    implements AddToDoEventCallBack {
  EventList markedDateMap = new EventList();

  static DateTime dateTime = DateTime.now();

  DateTime _currentDate = DateTime(dateTime.year, dateTime.month, dateTime.day);
  DateTime _currentDate2 =
      DateTime(dateTime.year, dateTime.month, dateTime.day);
  String _currentMonth = '';

  @override
  addEventSuccess(Event event) async {
    // TODO: implement addEventSuccess

    Event event2 =
        new Event(date: event.date, title: event.title, icon: _eventIcon);
    markedDateMap.add(event.date, event);

    DateTime dateTime = event.date;
    ToDoWorkBean toDoWorkBean = new ToDoWorkBean(dateTime.year, dateTime.month,
        dateTime.day, event.title, widget.userId);
    var value = await HttpUtil.uploadToDoWork(todoWorkbean: toDoWorkBean);
    if (!value["result"]) {
      //add success
    } else {
      //add fault¬
    }
  }

  static Widget _eventIcon = new Container(
    decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(1000.0)),
        border: Border.all(color: Colors.blue, width: 2.0)),
    child: new Icon(
      Icons.person,
      color: Colors.amber,
    ),
  );

  CalendarCarousel _calendarCarousel, _calendarCarouselNoHeader;

  @override
  void initState() {
    super.initState();
    initToDowork();
  }

  void initToDowork() async {
    var value = await HttpUtil.downloadToDoWork(widget.userId);
    if (value['result']) {
      EventList tempMarkedDateMap = new EventList();

      List<ToDoWorkBean> todoWorkBeans = value['todoWorkBeans'];

      for (ToDoWorkBean toDoWorkBean in todoWorkBeans) {
        DateTime dateTime = new DateTime(
            toDoWorkBean.year, toDoWorkBean.month, toDoWorkBean.day);
        Event event = new Event(
            date: dateTime, title: toDoWorkBean.content, icon: _eventIcon);
        tempMarkedDateMap.add(dateTime, event);
      }
      setState(() {
        markedDateMap = tempMarkedDateMap;
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    _calendarCarouselNoHeader = CalendarCarousel(
      onDayPressed: (DateTime date, List<Event> events) {
        this.setState(() => _currentDate2 = date);
        Navigator.push(context,
            new MaterialPageRoute(builder: (BuildContext context) {
          return new ManageTodoWorkPage(events, date, this);
        }));
      },
      weekendTextStyle: TextStyle(
        color: Colors.red,
      ),
      thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
      markedDatesMap: markedDateMap,
      height: 420.0,
      selectedDateTime: _currentDate2,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateShowIcon: true,
      markedDateIconMaxShown: 2,
      markedDateMoreShowTotal: false,
      // null for not showing hidden events indicator
      showHeader: false,
      minSelectedDate: _currentDate,
      maxSelectedDate: _currentDate.add(Duration(days: 60)),
      onCalendarChanged: (DateTime date) {
        this.setState(() => _currentMonth = DateFormat.yMMM().format(date));
      },
    );

    return new Scaffold(
        appBar: new AppBar(
          title: new Text("title"),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              //custom icon without header
              Container(
                margin: EdgeInsets.only(
                  top: 30.0,
                  bottom: 16.0,
                  left: 16.0,
                  right: 16.0,
                ),
                child: new Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      _currentMonth,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    )),
                    FlatButton(
                      child: Text('PREV'),
                      onPressed: () {
                        setState(() {
                          _currentDate2 =
                              _currentDate2.subtract(Duration(days: 30));
                          _currentMonth =
                              DateFormat.yMMM().format(_currentDate2);
                        });
                      },
                    ),
                    FlatButton(
                      child: Text('NEXT'),
                      onPressed: () {
                        setState(() {
                          _currentDate2 = _currentDate2.add(Duration(days: 30));
                          _currentMonth =
                              DateFormat.yMMM().format(_currentDate2);
                        });
                      },
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                child: _calendarCarouselNoHeader,
              ), //
            ],
          ),
        ));
  }
}
