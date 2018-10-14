import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_we/beans/data_responseinfo_bean.dart';
import 'package:flutter_we/beans/edit_list_bean.dart';
import 'package:flutter_we/beans/event_bean.dart';
import 'package:flutter_we/beans/events_bean.dart';
import 'package:flutter_we/utils/http_util.dart';

void main() {
  test("down load data  test", () async {
    DataResponseInfoBean dataResponseInfoBean =
        await HttpUtil.downloadData("testid");

    Map map = dataResponseInfoBean.datdaContent;

    map.forEach((key, value) {
      print("key:$key value:$value");
      //  Map<String,dynamic> map2=json.decode(value.toString());
      // print(value["content"]);
      // print(value["createdTime"]);
      Map timelineModelMap = json.decode(value["content"]);
      EditbeanList timelineModel = new EditbeanList.fromJson(timelineModelMap);
      print(timelineModel.list.length);
    });
  });
}
