import 'package:flutter/material.dart';
import 'package:kailo/utils/constants.dart';
import 'package:kailo/utils/radial_progress.dart';

class ResultsPage extends StatefulWidget {
  final String title;
  ResultsPage({Key key, this.title}) : super(key: key);
  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  @override
  void dispose() {
    finalTestScore = 0;
    scoreValues = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
    super.dispose();
  }

  String stressType;

  String getTextResult() {
    if (finalTestScore >= 0 && finalTestScore <= 13) {
      stressType = "low";
      return "Nice! You are a low Stressed Person";
    } else if (finalTestScore > 13 && finalTestScore < 27) {
      stressType = "med";
      return "Little Bit High,but can be easily Improved";
    } else if (finalTestScore >= 27 && finalTestScore <= 40) {
      stressType = "high";
      return "High!! Take a Deep Breath and Follow these steps";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade400,
        shape: CustomShapeBorder(),
        title: Align(
          widthFactor: 3,
          child: Column(
            children: [
              Container(
                child: Text(
                  "RESULT",
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  colors: [
                Colors.white,
                Colors.grey.shade100,
              ],
                  stops: [
                0.0,
                1.0
              ],
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  tileMode: TileMode.repeated)),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 50.0,
                  ),
                  RadialProgress(),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    height: 100.0,
                    padding: const EdgeInsets.all(1.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        child: Text(
                          getTextResult(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    padding: const EdgeInsets.all(1.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        child: Text(
                          "Our Suggestions",
                          style: TextStyle(
                            color: Colors.red.shade500,
                            fontSize: 30.0,
                            letterSpacing: -2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 7.0,
                  ),
                  stressType == 'low'
                      ? LowStress()
                      : stressType == 'med'
                          ? MediumStress()
                          : HighStress(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LowStress extends StatelessWidget {
  const LowStress({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      color: Colors.grey.shade100,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: _stressSubmary(
        help1:
            'Try to find an exercise routine or activity you enjoy, such as walking, dancing, rock climbing.',
        help2:
            'Having strong social ties may help you get through stressful times and lower your risk of anxiety.',
        help3:
            'There are several methods for increasing mindfulness, including mindfulness-based cognitive therapy, mindfulness-based stress reduction, yoga and meditation.',
        help4:
            'Listening to music you like can be a good way to relieve stress.',
        help5:
            'Spending time with your pet is a relaxing, enjoyable way to reduce stress.',
      ),
    );
  }
}

class MediumStress extends StatelessWidget {
  const MediumStress({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      height: 300.0,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: _stressSubmary(
        help1:
            'Try not to take on more than you can handle. Saying no is one way to control your stressors.',
        help2:
            'Prioritize what needs to get done and make time for it. Staying on top of your to-do list can help ward off procrastination-related stress.',
        help3:
            'Positive touch from cuddling, may help lower stress by releasing oxytocin and lowering blood pressure.',
        help4:
            'Find the humor in everyday life, spend time with funny friends or watch a comedy show to help relieve stress.',
        help5:
            'According to several studies, chewing gum may help you relax. It may also promote wellbeing and reduce stress.',
      ),
    );
  }
}

class HighStress extends StatelessWidget {
  const HighStress({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      color: Colors.grey.shade100,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: _stressSubmary(
        help1:
            'Deep breathing activates the relaxation response. Multiple methods can help you learn how to breathe deeply.',
        help2:
            'Keeping a journal can help relieve stress and anxiety, especially if you focus on the positive.',
        help3:
            'High quantities of caffeine can increase stress and anxiety. However, people’s sensitivity to caffeine can vary greatly.',
        help4:
            'Certain supplements can reduce stress and anxiety, including ashwagandha, omega-3 fatty acids, green tea and lemon balm.',
        help5:
            'Aromatherapy can help lower anxiety and stress. Light a candle or use essential oils to benefit from calming scents.',
      ),
    );
  }
}

class CustomShapeBorder extends ContinuousRectangleBorder {
  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    final double innerCircleRadius = 45.0;
    double heights = 130;

    Path path = Path();

    path.lineTo(0, heights);
    path.quadraticBezierTo(rect.width / 2 - (innerCircleRadius / 2) - 30,
        heights + 15, rect.width / 2 - 75, heights + 50);
    path.cubicTo(
        rect.width / 2 - 40,
        heights + innerCircleRadius - 40,
        rect.width / 2 + 40,
        heights + innerCircleRadius - 40,
        rect.width / 2 + 75,
        heights + 50);
    path.quadraticBezierTo(rect.width / 2 + (innerCircleRadius / 2) + 30,
        heights + 15, rect.width, heights);
    path.lineTo(rect.width, 0.0);
    path.close();

    return path;
  }
}

class _stressSubmary extends StatelessWidget {
  final String help1;
  final String help2;
  final String help3;
  final String help4;
  final String help5;

  const _stressSubmary(
      {Key key, this.help1, this.help2, this.help3, this.help4, this.help5})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      // shrinkWrap: true,
      // physics: NeverScrollableScrollPhysics(),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              help1,
              textAlign: TextAlign.center,
              style: ktextStyle(),
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              help2,
              textAlign: TextAlign.center,
              style: ktextStyle(),
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              help3,
              textAlign: TextAlign.center,
              style: ktextStyle(),
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              help4,
              textAlign: TextAlign.center,
              style: ktextStyle(),
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              help5,
              textAlign: TextAlign.center,
              style: ktextStyle(),
            ),
          ),
        ),
      ],
    );
  }
}
