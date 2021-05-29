import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kailo/Screens/editDetails.dart';
import 'package:kailo/resources/authentication.dart';

class ViewUserSettings extends StatefulWidget {
  @override
  _ViewUserSettingsState createState() => _ViewUserSettingsState();
}

class _ViewUserSettingsState extends State<ViewUserSettings> {
  String bio;
  String name;
  int age;
  String profilePhoto;
  Future<void> createUserProfile() async {
    User user = await getCurrentUser();
    try {
      var data = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .get();
      this.setState(() {
        name = data.data()["name"];
        bio = data.data()["bio"];
        age = data.data()["age"];
        profilePhoto = data.data()["profile_photo"];
      });
      print(data.data()["profile_photo"]);
    } catch (err) {
      print("profile-----error");
    }
  }

  @override
  void initState() {
    createUserProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 14.0),
              Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: profilePhoto != null
                      ? NetworkImage(profilePhoto)
                      : AssetImage('assets/images/profile.png'),
                  radius: 70.0,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 500.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        Align(
                          heightFactor: 1,
                          alignment: Alignment.center,
                          child: Text(
                            name == null ? "Enter Name " : name,
                            style: TextStyle(
                              fontSize: 40.0,
                            ),
                          ),
                        ),
                        Align(
                          heightFactor: 6.0,
                          alignment: Alignment.center,
                          child: Text(
                            age == null ? 'Age ' : "Age: ${age}",
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                        Align(
                          heightFactor: 5.0,
                          alignment: Alignment.center,
                          child: ElevatedButton(
                              child: Container(
                                width: 110.0,
                                height: 40.0,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(Icons.edit),
                                    Text('Edit Profile'),
                                  ],
                                ),
                              ),
                              style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.purple),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          side: BorderSide(
                                              color: Colors.purple)))),
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EditUserSettings()));
                              }),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              heightFactor: 9.2,
                              alignment: Alignment.center,
                              child: Container(
                                child: Text(
                                  "Bio",
                                  style: TextStyle(
                                      fontSize: 35.0,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Align(
                          heightFactor: 2.2,
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Text(
                              bio == null ? "Enter Bio" : bio,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 25.0, fontWeight: FontWeight.w300),
                            ),
                            height: 200.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                topRight: Radius.circular(30.0),
                                bottomLeft: Radius.circular(30.0),
                                bottomRight: Radius.circular(30.0),
                              ),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
