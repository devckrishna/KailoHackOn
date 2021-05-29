import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:kailo/models/PostModel.dart';
import 'package:kailo/resources/authentication.dart';

class PostNotifier extends ChangeNotifier {
  List<PostModel> _posts = [];
  Future<void> createPostList() async {
    User user = await getCurrentUser();
    Stream<QuerySnapshot> stream = FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .collection("posts")
        .snapshots();
    print("-----------------here-------------------");
    stream.listen((snapshot) {
      snapshot.docs.forEach((element) {
        PostModel post = PostModel.fromMap(element.data());
        _posts.add(post);
      });
    });
  }

  List<PostModel> get posts {
    createPostList().then((value) => _posts);
  }
}
