import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kailo/Screens/home_screen.dart';
import 'package:kailo/resources/authentication.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _email;
  String _password;
  bool isLoading = false;
  bool showLoading = false;
  bool isLoginPressed = false;

  void authenticateUsers(UserCredential user) {
    authenticateUser(user).then((isNewUser) {
      setState(() {
        isLoginPressed = false;
      });
      if (isNewUser) {
        addDataToDb(user.user).then((value) => Navigator.of(context)
            .pushReplacement(
                MaterialPageRoute(builder: (context) => HomeScreen())));
      } else {
        return Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    });
  }

  registerUser() async {
    _formKey.currentState.save();
    print(_email);
    print(_password);
    try {
      setState(() {
        isLoading = true;
        showLoading = true;
      });
      UserCredential isSignedUp = await signInWithEmail(_email, _password);
      if (isSignedUp != null) {
        UserCredential isSignedIn = await loginUser(_email, _password);
        if (isSignedIn != null) {
          setState(() {
            isLoading = false;
            showLoading = false;
          });
          authenticateUsers(isSignedIn);
        }
      }
    } catch (e) {
      print("something went wrong");
    }
    setState(() {
      isLoading = false;
      showLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor("#000022"),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 120),
                  child: Text("Create New Account",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1))),
              Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 10),
                  child: Text("Please fill in the form to continue",
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: 15,
                          letterSpacing: 1.2))),
              Form(
                key: _formKey,
                child: Column(children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    margin: EdgeInsets.only(left: 20, right: 20, top: 70),
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20)),
                    child: TextFormField(
                      controller: _emailController,
                      onSaved: (text) => this._email = text,
                      decoration: new InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintStyle:
                              TextStyle(fontSize: 18.0, color: Colors.white70),
                          hintText: "Email"),
                      style: TextStyle(fontSize: 18.0, color: Colors.white70),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20)),
                    child: TextFormField(
                      decoration: new InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintStyle:
                              TextStyle(fontSize: 18.0, color: Colors.white70),
                          hintText: "Confirm Email"),
                      style: TextStyle(fontSize: 18.0, color: Colors.white70),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20)),
                    child: TextFormField(
                      controller: _passwordController,
                      onSaved: (text) => this._password = text,
                      obscureText: true,
                      decoration: new InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintStyle:
                              TextStyle(fontSize: 18.0, color: Colors.white70),
                          hintText: "Password"),
                      style: TextStyle(fontSize: 18.0, color: Colors.white70),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20)),
                    child: TextFormField(
                      obscureText: true,
                      decoration: new InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintStyle:
                              TextStyle(fontSize: 18.0, color: Colors.white70),
                          hintText: "Confirm Password"),
                      style: TextStyle(fontSize: 18.0, color: Colors.white70),
                    ),
                  ),
                ]),
              ),
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(50)),
                margin: EdgeInsets.only(bottom: 0, top: 80),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: HexColor("#653aff"),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                      ),
                    ),
                    onPressed: () => registerUser(),
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.82,
                      padding: EdgeInsets.all(23),
                      child: Text(
                        "Sign-Up",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2),
                      ),
                    )),
              ),
              Container(
                margin: EdgeInsets.only(top: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account ",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 2),
                    ),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Text(
                        "Sign-In ",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
