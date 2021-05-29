import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kailo/Screens/home_screen.dart';
import 'package:kailo/models/PostModel.dart';
import 'package:kailo/resources/authentication.dart';

class ContentScreen extends StatefulWidget {
  static const routeName = "/add-content";
  @override
  _ContentScreenState createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String _title = "";
  String _content = "";
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  void addTo(String currTitle, String currContent, String feeling) async {
    User user = await getCurrentUser();
    PostModel post = new PostModel(
        uid: user.uid,
        userName: user.displayName,
        content: currContent,
        title: currTitle,
        feeling: feeling,
        time: DateTime.now(),
        likes: 0);
    FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .collection("posts")
        .doc(DateTime.now().toString())
        .set(post.toMap(post));
  }

  @override
  Widget build(BuildContext context) {
    final String feeling = "happy";
    // final List activity = [];
    return Scaffold(
        backgroundColor: HexColor("#442A3F"),
        body: Stack(children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.93,
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [HexColor("9D6AF2"), HexColor("8642F7")]),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      topLeft: Radius.circular(40))),
              child: SingleChildScrollView(
                child: Column(children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 23, top: 20),
                        child: IconButton(
                            color: Colors.white,
                            iconSize: 35,
                            icon: Icon(Icons.arrow_back),
                            onPressed: () => Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                                    builder: (context) => HomeScreen()))),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      decoration: InputDecoration(
                        hoverColor: Colors.white,
                        fillColor: Colors.deepPurpleAccent[100],
                        filled: true,
                        hintText: "Highlights Of Your Day",
                        hintStyle: TextStyle(fontSize: 22, color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      controller: _titleController,
                      onSubmitted: (text) {
                        setState(() {
                          _title = _titleController.text;
                        });
                        print(_title);
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    height: 350,
                    decoration: BoxDecoration(
                        color: Colors.deepPurpleAccent[100],
                        borderRadius: BorderRadius.circular(20)),
                    child: TextFormField(
                      minLines: 17, //Normal textInputField will be displayed
                      maxLines: 17,
                      decoration: InputDecoration(
                          hoverColor: Colors.white,
                          fillColor: Colors.deepPurpleAccent[100],
                          filled: true,
                          hintText: "Enter your story",
                          hintStyle:
                              TextStyle(fontSize: 22, color: Colors.white),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          border: InputBorder.none),
                      controller: _contentController,
                      keyboardType: TextInputType.multiline,
                      onSaved: (value) {
                        _content = _contentController.text;
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: RaisedButton(
                          onPressed: () {
                            setState(() {
                              _content = _contentController.text;
                            });
                            addTo(_titleController.text, _content, feeling);

                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 40),
                          child: Text(
                            "Submit",
                            style: TextStyle(fontSize: 15, letterSpacing: 1),
                          ),
                        ),
                      ),
                    ],
                  )
                ]),
              ),
            ),
          )
        ]));
  }
}
