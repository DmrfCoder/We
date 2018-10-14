class DataResponseInfoBean {
  bool result=false;
  String desc;

  String objectId;

  Map datdaContent;

  DataResponseInfoBean({this.result, this.desc, this.objectId, this.datdaContent}) {
    print("result:" + result.toString());
    print("desc:" + desc);

    //print("id:" + objectId);
   // print("datdaContent"+datdaContent);
  }
}
