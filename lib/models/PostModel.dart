import 'package:intl/intl.dart';

class PostModel {
  String uid;
  String userName;
  String content;
  String title;
  String feeling;
  DateTime time;
  int likes;

  PostModel(
      {this.uid,
      this.userName,
      this.content,
      this.title,
      this.feeling,
      this.time,
      this.likes});

  Map toMap(PostModel post) {
    var data = Map<String, dynamic>();
    data['uid'] = post.uid;
    data['username'] = post.userName;
    data['content'] = post.content;
    data['feeling'] = post.feeling;
    data['time'] = post.time;
    data['likes'] = post.likes;
    data["title"] = post.title;
    return data;
  }

  PostModel.fromMap(Map<String, dynamic> mapData) {
    this.uid = mapData["uid"];
    this.userName = mapData["username"];
    this.content = mapData["content"];
    this.feeling = mapData["feeling"];
    this.time = mapData["time"].toDate();
    this.likes = mapData["likes"];
    this.title = mapData["title"];
    this.uid = mapData["uid"];
  }
}
