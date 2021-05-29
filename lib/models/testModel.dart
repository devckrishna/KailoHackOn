import 'package:cloud_firestore/cloud_firestore.dart';

class TestModel {
  double result;
  String time;
  String uid;

  TestModel({
    this.result,
    this.time,
    this.uid,
  });

  Map<dynamic, dynamic> toMap(TestModel test) {
    var data = Map<String, dynamic>();
    data['result'] = test.result;
    data['time'] = test.time;
    data['uid'] = test.uid;
    return data;
  }

  TestModel.fromMap(Map<String, dynamic> mapData) {
    this.uid = mapData['uid'];
    this.time = mapData['time'].toString();
    this.result = mapData['result'];
  }

}
