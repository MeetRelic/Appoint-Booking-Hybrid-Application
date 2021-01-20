import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PieChartSample1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PieChartSample1State();
}

class PieChartSample1State extends State {
  int touchedIndex;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Card(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 28,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // Indicator(
                //   color: const Color(0xff0293ee),
                //   text: 'One',
                //   isSquare: false,
                //   size: touchedIndex == 0 ? 18 : 16,
                //   textColor: touchedIndex == 0 ? Colors.black : Colors.grey,
                // ),
                // Indicator(
                //   color: const Color(0xfff8b250),
                //   text: 'Two',
                //   isSquare: false,
                //   size: touchedIndex == 1 ? 18 : 16,
                //   textColor: touchedIndex == 1 ? Colors.black : Colors.grey,
                // ),
                // Indicator(
                //   color: const Color(0xff845bef),
                //   text: 'Three',
                //   isSquare: false,
                //   size: touchedIndex == 2 ? 18 : 16,
                //   textColor: touchedIndex == 2 ? Colors.black : Colors.grey,
                // ),
                // Indicator(
                //   color: const Color(0xff13d38e),
                //   text: 'Four',
                //   isSquare: false,
                //   size: touchedIndex == 3 ? 18 : 16,
                //   textColor: touchedIndex == 3 ? Colors.black : Colors.grey,
                // ),
              ],
            ),
            // const SizedBox(
            //   height: 18,
            // ),
            Text(
              "Meet Trial ",
              style: TextStyle(fontSize: 26),
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                      pieTouchData:
                          PieTouchData(touchCallback: (pieTouchResponse) {
                        print(pieTouchResponse.touchedSectionIndex);
                        setState(() {
                          if (pieTouchResponse.touchInput is FlLongPressEnd ||
                              pieTouchResponse.touchInput is FlPanEnd) {
                            touchedIndex = -1;
                          } else {
                            touchedIndex = pieTouchResponse.touchedSectionIndex;
                            if (touchedIndex == 1) {
                              _launchUniversalLinkIos(
                                  "https://www.youtube.com/");
                            }
                          }
                        });
                      }),
                      startDegreeOffset: 180,
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 3,
                      centerSpaceRadius: 0,
                      sections: showingSections()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUniversalLinkIos(String url) async {
    final bool nativeAppLaunchSucceeded = await launch(
      url,
      forceSafariVC: false,
      universalLinksOnly: true,
    );
    if (!nativeAppLaunchSucceeded) {
      await launch(url, forceSafariVC: true);
    }
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(
      4,
      (i) {
        final isTouched = i == touchedIndex;
        final double opacity = isTouched ? 1 : 0.6;
        final double radion = isTouched ? 120 : 100;
        // final dou
        switch (i) {
          case 0:
            return PieChartSectionData(
              color: const Color(0xff0293ee).withOpacity(opacity),
              value: 25,
              title: 'Physical',
              radius: radion,
              titleStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff044d7c)),
              titlePositionPercentageOffset: 0.55,
            );
          case 1:
            return PieChartSectionData(
              color: const Color(0xfff8b250).withOpacity(opacity),
              value: 25,
              title: 'financial',
              radius: radion,
              titleStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff90672d)),
              titlePositionPercentageOffset: 0.55,
            );
          case 2:
            return PieChartSectionData(
              color: const Color(0xff845bef).withOpacity(opacity),
              value: 25,
              title: 'Emotional',
              radius: radion,
              titleStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff4c3788)),
              titlePositionPercentageOffset: 0.6,
            );
          case 3:
            return PieChartSectionData(
              color: const Color(0xff13d38e).withOpacity(opacity),
              value: 25,
              title: 'Spiritual',
              radius: radion,
              titleStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff0c7f55)),
              titlePositionPercentageOffset: 0.55,
            );
          default:
            return null;
        }
      },
    );
  }
}
