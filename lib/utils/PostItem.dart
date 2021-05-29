import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kailo/Screens/home_screen.dart';
import 'package:kailo/models/PostModel.dart';
import 'package:kailo/resources/authentication.dart';
import 'package:kailo/utils/BlurryDialog.dart';

class PostItem extends StatefulWidget {
  String content;
  String feeling;
  int likes;
  DateTime time;
  String title;

  PostItem({
    this.content,
    this.feeling,
    this.likes,
    this.time,
    this.title,
  });

  @override
  _PostItemState createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  String statusOfPostItem;
 
  void addPostToDataBase(BuildContext context) async {
    VoidCallback continueCallBack = () async {
      User user = await getCurrentUser();
      PostModel post = new PostModel(
          uid: user.uid,
          userName: user.displayName,
          content: widget.content,
          title: widget.title,
          feeling: widget.feeling,
          time: widget.time,
          likes: 0);
      FirebaseFirestore.instance
          .collection("feed")
          .doc(DateTime.now().toString())
          .set(post.toMap(post));

      Navigator.of(context, rootNavigator: true).pop();

      // code on continue comes here
    };
    BlurryDialog alert = BlurryDialog("Upload Experience",
        "Are you sure you want to upload?", continueCallBack);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  String monthConvertor(String curr) {
    if (curr == "01") {
      return "Jan";
    } else if (curr == "02") {
      return "Feb";
    } else if (curr == "03") {
      return "Mar";
    } else if (curr == "04") {
      return "Apr";
    } else if (curr == "05") {
      return "May";
    } else if (curr == "06") {
      return "June";
    } else if (curr == "07") {
      return "July";
    } else if (curr == "08") {
      return "Aug";
    } else if (curr == "09") {
      return "Sept";
    } else if (curr == "10") {
      return "Oct";
    } else if (curr == "11") {
      return "Nov";
    } else if (curr == "12") {
      return "Dec";
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 200,
        width: 10,
        margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 8.0)],
            color: Colors.white70,
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 90.0,
              color: Colors.deepPurple.shade600,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.time.toString().split(" ")[1].split(".")[0],
                    style: TextStyle(
                        fontSize: 10.0,
                        fontStyle: FontStyle.italic,
                        color: Colors.white70),
                  ),
                  Text(
                    monthConvertor(
                        widget.time.toString().split(" ")[0].split("-")[1]),
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white70),
                  ),
                  IconButton(
                      onPressed: () => addPostToDataBase(context),
                      icon: FaIcon(
                        FontAwesomeIcons.shareAlt,
                        color: Colors.white,
                      ))
                ],
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: Center(
                        child: Text(
                      widget.title,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    )),
                    //color: Colors.yellow,
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    height: 100,
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: Center(
                      child: Text(
                        widget.content,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                          boxShadow: [
                              BoxShadow(
                                  color: Colors.greenAccent, blurRadius: 5.0)
                            ],
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.green,
                          ),

                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
