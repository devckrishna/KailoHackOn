import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kailo/Screens/add_activity.dart';
import 'package:kailo/models/PostModel.dart';
import 'package:kailo/notifiers/PostNotifier.dart';
import 'package:kailo/resources/authentication.dart';
import 'package:kailo/utils/PostItem.dart';
import 'package:provider/provider.dart';

import '../utils/PostItem.dart';
import '../utils/constants.dart';

class DashBoardScreen extends StatefulWidget {
  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  String name;
  String profilePhoto = "http://simpleicon.com/wp-content/uploads/account.png";
  List<PostModel> posts = [];
  bool isLoading = false;
  Future<void> currentUser() async {
    User curr = await getCurrentUser();
    var data = await FirebaseFirestore.instance
        .collection("users")
        .doc(curr.uid)
        .get();

    this.setState(() {
      if (data.data()["name"] != null) {
        name = data.data()["name"].split(" ")[0];
        profilePhoto = data.data()["profile_photo"];
      } else {
        name = "";
      }
    });
  }

  void createPostList() async {
    this.setState(() {
      posts = [];
      isLoading = true;
    });
    User user = await getCurrentUser();
    Stream<QuerySnapshot> stream = FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .collection("posts")
        .snapshots();

    stream.listen((snapshot) {
      snapshot.docs.forEach((element) {
        PostModel post = PostModel.fromMap(element.data());
        this.setState(() {
          posts.add(post);
        });
      });
    });
    this.setState(() {
      print("-----------------here-------------------");
      isLoading = false;
      print(posts.length);
    });
  }

  @override
  void initState() {
    currentUser();
    createPostList();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        itemCount: posts.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return isLoading
                ? Center(
                    child: Text("Loading.."),
                  )
                : Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20, left: 30, right: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              radius: 27,
                              backgroundColor: Colors.grey[400],
                              backgroundImage: NetworkImage(profilePhoto),
                            ),
                            IconButton(
                              icon: FaIcon(FontAwesomeIcons.bars),
                              onPressed: () =>
                                  Scaffold.of(context).openEndDrawer(),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        child: Text(name == null ? "Hi!" : "Hi! ${name} ",
                            style: GoogleFonts.roboto(
                                fontSize: 40,
                                letterSpacing: 4,
                                fontWeight: FontWeight.w500)),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      posts.length == 0
                          ? Container(
                              child: Text("please add somethiing"),
                            )
                          : Container()
                    ],
                  );
          }
          index -= 1;
          if (posts.length == 0) {
            return Container(
                height: 2000, color: Colors.red, child: Text("some"));
          }
          PostModel temp = posts[index];
          return PostItem(
            content: temp.content,
            feeling: temp.feeling,
            time: temp.time,
            likes: temp.likes,
            title: temp.title,
          );
        },
      ),
    ));
  }
}
