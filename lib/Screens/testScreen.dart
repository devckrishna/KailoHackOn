import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kailo/Screens/resultsPage.dart';
import 'package:kailo/models/testModel.dart';
import 'package:kailo/resources/authentication.dart';
import 'package:kailo/utils/add_options.dart';
import 'package:kailo/utils/constants.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TestScreen(title: 'Flutter Demo Home Page'),
    );
  }
}

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}

class TestScreen extends StatefulWidget {
  TestScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<TestScreen> {
  Future<void> _addToDatabase(double score, DateTime dateTime) async {
    User user = await getCurrentUser();
    TestModel _testModel = new TestModel(
      result: score,
      uid: user.uid,
      time: dateTime.toString(),
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('results')
        .doc(DateTime.now().toString())
        .set(_testModel.toMap(_testModel));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.grey,
        title: Center(
          child: Text(
            'Stress Test',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black54,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 18.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'How often have you been upset because of something that happened unexpectedly?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                ),
                AddOption(0, 0),
                SizedBox(
                  height: 10,
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'How often have you felt that you were unable to control the important things in your life?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                ),
                AddOption(1, 0),
                SizedBox(
                  height: 10,
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'How often have you felt nervous and stressed?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                ),
                AddOption(2, 0),
                SizedBox(
                  height: 10,
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'How often have you felt confident about your ability to handle your personal problems?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                ),
                AddOption(3, 0),
                SizedBox(
                  height: 10,
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'How often have you felt that things were going your way?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                ),
                AddOption(4, 0),
                SizedBox(
                  height: 10,
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'How often have you found that you could not cope with all the things that you had to do?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                ),
                AddOption(5, 0),
                SizedBox(
                  height: 10,
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'How often have you been able to control irritations in your life?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Roboto',
                    fontSize: 17,
                  ),
                ),
                AddOption(6, 0),
                SizedBox(
                  height: 10,
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'How often have you felt that you were on top of things?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                ),
                AddOption(7, 0),
                SizedBox(
                  height: 10,
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'How often have you been angered because of things that happened that were outside of your control?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                ),
                AddOption(8, 0),
                SizedBox(
                  height: 10,
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'How often have you felt difficulties were piling up so high that you could not overcome them?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                ),
                AddOption(9, 0),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 50.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.yellow.shade700,
                    ),
                    onPressed: () {
                      setState(() {
                        for (int i = 0; i < scoreValues.length; i++) {
                          if (i == 3 || i == 4 || i == 6 || i == 7) {
                            finalTestScore += (4.0 - scoreValues[i]);
                          } else {
                            finalTestScore += scoreValues[i];
                          }
                        }
                        _addToDatabase(finalTestScore, DateTime.now());
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResultsPage(),
                            ));
                      });
                    },
                    child: Text(
                      'SUBMIT',
                      style: ktextStyle().copyWith(color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(height: 100.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
