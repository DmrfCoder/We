import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_we/beans/constant_bean.dart';
import 'package:flutter_we/callback/index_page_callback.dart';
import 'package:flutter_we/pages/user_center_page.dart';
import 'package:flutter_we/pages/todo_work_page.dart';
import 'package:flutter_we/pages/we_page.dart';
import 'package:flutter_we/utils/share_preferences_util.dart';

class IndexPage extends StatefulWidget implements IndexPageCallBack {
  String userid;
  String phoneNumber;
  String sessionToken;
  List<Widget> tabBodies = new List();
  WeListPage weListPage;
  ToDoWorkPage toDoWorkPage;
  UserCenterPage userCenterPage;

  IndexPage(this.userid, this.phoneNumber, this.sessionToken) {
    weListPage = new WeListPage(userid, phoneNumber, sessionToken);
    toDoWorkPage = new ToDoWorkPage(userid);
    userCenterPage = new UserCenterPage(userid, phoneNumber, this);

    tabBodies = [weListPage, toDoWorkPage, userCenterPage];
  }

  @override
  State<StatefulWidget> createState() => new IndexPageState();

  @override
  associteFromUserCenterCallBack(String otherId) {
    // TODO: implement associteFromUserCenterCallBack
    weListPage.weControllor.otherId = otherId;
    weListPage.weControllor.isMarried = true;
    weListPage.weControllor.init();
    return null;
  }

  @override
  swichSychDataUserCenterCallBack(bool swichValue) async {
    // TODO: implement swichSychDataUserCenterCallBack
    bool setFlag =
        await weListPage.weControllor.setSychWithServerFlag(swichValue);
    return setFlag;
  }
}

class IndexPageState extends State<IndexPage>
    with AutomaticKeepAliveClientMixin {
  //  定义底部导航列表
  final List<BottomNavigationBarItem> bottomTabs = [
    new BottomNavigationBarItem(
      icon: new Icon(CupertinoIcons.home),
      title: new Text('便签'),
    ),
    new BottomNavigationBarItem(
        icon: new Icon(Icons.calendar_today), title: new Text('日程表')),
    new BottomNavigationBarItem(
        icon: new Icon(CupertinoIcons.profile_circled), title: new Text('我'))
  ];

  int currentIndex = 0; //当前索引
  Widget currentPage; //当前页面

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentPage = widget.tabBodies[currentIndex];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      bottomNavigationBar: new CupertinoTabBar(
          currentIndex: currentIndex,
          backgroundColor: Color.fromRGBO(245, 194, 250, 1.0),
          items: bottomTabs,
          onTap: (index) {
            setState(() {
              currentIndex = index;
              currentPage = widget.tabBodies[currentIndex];
            });
          }),
      body: currentPage,
    );
  }

  // TODO: implement wantKeepAlive
  @override
  bool get wantKeepAlive => true;
}
