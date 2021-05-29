import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kailo/models/PostModel.dart';
import 'package:kailo/resources/authentication.dart';
import 'package:kailo/utils/feedCard.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  List<PostModel> feeds = [];
  bool isLoading = false;

  void createFeedList() async {
    User user = await getCurrentUser();
    this.setState(() {
      feeds = [];
      isLoading = true;
    });
    Stream<QuerySnapshot> stream =
        FirebaseFirestore.instance.collection("feed").snapshots();
    print("-----------------heremot-------------------");
    stream.listen((snapshot) {
      snapshot.docs.forEach((element) {
        // print("num");
        // print(element.data());
        PostModel post = PostModel.fromMap(element.data());
        this.setState(() {
          feeds.add(post);
        });
      });
      print(feeds.length);
    });
    this.setState(() {
      List<PostModel> newFeeds = new List.from(feeds.reversed);
      feeds = newFeeds;
      isLoading = false;
    });
  }

  @override
  void initState() {
    createFeedList();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        itemCount: feeds.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return isLoading
                ? Center(
                    child: Text("Loading.."),
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        child: Text("Feed",
                            style: GoogleFonts.roboto(
                                fontSize: 40,
                                letterSpacing: 4,
                                fontWeight: FontWeight.w500)),
                      ),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  );
          }
          index -= 1;
          PostModel temp = feeds[index];
          return FeedCard(
            content: temp.content,
            feeling: temp.feeling,
            time: temp.time,
            likes: temp.likes,
            title: temp.title,
            uid: temp.uid,
          );
        },
      ),
    ));
  }
}
