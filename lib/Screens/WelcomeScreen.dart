import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kailo/Screens/login_screen.dart';

import 'home_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ShaderMask(
      shaderCallback: (rect) {
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.black, Colors.black],
        ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
      },
      blendMode: BlendMode.dstIn,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/WelcomeBack.jpg"),
              fit: BoxFit.cover),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Text(
              "Kailo",
              style: GoogleFonts.satisfy(
                  color: Colors.white,
                  fontSize: 50,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            child: Text(
              "Mental Health Is More Important Than You Think",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
            margin: EdgeInsets.only(bottom: 50, top: 15),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: HexColor("#653aff"),
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0),
                  ),
                ),
                onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginScreen())),
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.75,
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Get Started",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2),
                  ),
                )),
          )
        ]),
      ),
    ));
  }
}
