import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:kailo/models/testModel.dart';

class MyHealthChart extends StatefulWidget {
  final List<TestModel> prevResults;
  final int length;

  MyHealthChart(this.prevResults, this.length);
  @override
  State<StatefulWidget> createState() => MyHealthChartState();
}

class MyHealthChartState extends State<MyHealthChart> {
  bool isShowingMainData;

  List<FlSpot> makeSpots() {
    List<double> yValues = [];
    for (int i = 0; i < widget.length; i++) {
      yValues.add(widget.prevResults[i].result.toDouble() / 10);
    }

    return yValues.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), e.value);
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.23,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            gradient: LinearGradient(
              colors: [
                Colors.white,
                Colors.grey,
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      'Stress Report',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16.0, left: 6.0),
                        child: LineChart(
                          sampleData2(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  LineChartData sampleData2() {
    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: true,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff72719b),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          margin: 10,
          getTitles: (value) {
            switch (value.toInt()) {
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff75729e),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '10';
              case 2:
                return '20';
              case 3:
                return '30';
              case 4:
                return '40';
            }
            return "";
          },
          margin: 8,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: const Border(
            bottom: BorderSide(
              color: Color(0xff4e4965),
              width: 4,
            ),
            left: BorderSide(
              color: Colors.transparent,
            ),
            right: BorderSide(
              color: Colors.transparent,
            ),
            top: BorderSide(
              color: Colors.transparent,
            ),
          )),
      maxX: widget.length.toDouble(),
      minX: -1,
      maxY: 4,
      minY: 0,
      lineBarsData: linesBarData2(),
    );
  }

  List<LineChartBarData> linesBarData2() {
    return [
      LineChartBarData(
        preventCurveOverShooting: true,
        spots: makeSpots() == null ? [] : makeSpots(),
        isCurved: true,
        curveSmoothness: 0,
        colors: const [
          Colors.blue,
        ],
        barWidth: 4,
        isStrokeCapRound: false,
        dotData: FlDotData(
          show: true,
        ),
        belowBarData: BarAreaData(
          show: false,
        ),
      ),
    ];
  }
}
