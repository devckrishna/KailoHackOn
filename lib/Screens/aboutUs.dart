import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Image.network(
                  'https://www.poynter.org/wp-content/uploads/2019/03/shutterstock_446870920-1500x1001.jpg'),
            ),
            Align(
              alignment: Alignment.topCenter,
              widthFactor: 1.5,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Icon(
                    Icons.arrow_back,
                    size: 30.0,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 580.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                  gradient: new LinearGradient(
                      colors: [
                        Colors.white,
                        Colors.grey,
                      ],
                      stops: [
                        0.0,
                        1.0
                      ],
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                      tileMode: TileMode.repeated),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Kailo is an emotional wellness application whose apparatuses and understanding are intended to "shape up" your state of mind. This application is intended to assist you with getting mental shape. Regardless of whether you are hoping to all the more likely comprehend your sentiments, or you are encountering tension, sorrow, or undeniable degrees of stress, Kailo is intended to help you feel much improved.',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                fontSize: 17.0,
                                letterSpacing: 2.0,
                                wordSpacing: 3.0,
                                fontFamily: 'Oswald'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 20.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Kailo likewise permits you to follow your mind-sets. Over the long haul, you will better comprehend what kinds of things influence your sentiments—like rest, medicine, and exercise. The application offers noteworthy experiences into what influences your temperament and gives techniques to feeling much improved.',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 17.0,
                              letterSpacing: 2.0,
                              wordSpacing: 2.0,
                            ),
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
    );
  }
}
