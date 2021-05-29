import 'package:cloud_firestore/cloud_firestore.dart';

class TestModel {
  String result;
  DateTime time;

  TestModel({
    this.result,
    this.time,
  });

  Map<dynamic, dynamic> toMap(TestModel test) {
    var data = Map<String, dynamic>();
    data['result'] = test.result;
    data['time'] = test.time;
    return data;
  }
}
