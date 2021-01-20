import 'package:first_app/E-Meeting//DashboardFinal.dart';

import 'package:first_app/Models/rating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';

final Color backgroundColor = Color(0xFF4A4A58);

class MenuDashboardPage14 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'HOME',
      home: MenuDashboardPage111(),
    );
  }
}

class MenuDashboardPage111 extends StatefulWidget {
  @override
  _MenuDashboardPageState211 createState() => _MenuDashboardPageState211();
}

class _MenuDashboardPageState211 extends State<MenuDashboardPage111>
    with SingleTickerProviderStateMixin {
  final _rate = Rating();

  double value1 = 0.0;
  double value2 = 0.0;
  double value3 = 0.0;
  double value4 = 0.0;
  bool isCollapsed = true;
  double screenWidth, screenHeight;

  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: <Widget>[
          menu(context),
          dashboard(context),
        ],
      ),
    );
  }

  Widget menu(context) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Dashboard",
                    style: TextStyle(color: Colors.white, fontSize: 22)),
                SizedBox(height: 10),
                // new SizedBox(height: 100,),
                new ExpansionTile(
                  leading: new Icon(
                    Icons.arrow_drop_down,
                    color: Colors.red,
                  ),
                  title: Text(
                    'MEETING  ',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Montserrat',
                      fontStyle: FontStyle.italic,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                  children: <Widget>[
                    Align(
                        alignment: Alignment.topLeft,
                        child: new FlatButton(
                          child: Text(
                            'Forgot Password',
                            style: TextStyle(
                              fontSize: 12.0, color: Colors.greenAccent,

                              fontWeight: FontWeight.bold,
                              //decoration: TextDecoration.none,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new DSB()),
                            );
                          },
                          //style: TextStyle(color: Colors.white,fontSize: 20,
                        )
                        //     new SizedBox(height: 2,),
                        )
                  ],
                )

                // ListTile(
                //   title: Text(
                //     "Meetings", style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.w300

                //   ),
                // )
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dashboard(context) {
    const ticks = [10, 20, 30, 40, 50];
    var features = ["Q1", "Q2", "CC", "DD"];
    var data = [
      [11, 12, 48, 12],
    ];
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.6 * screenWidth,
      right: isCollapsed ? 0 : -0.2 * screenWidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          animationDuration: duration,
          borderRadius: BorderRadius.all(Radius.circular(40)),
          elevation: 8,
          color: backgroundColor,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
//                       SizedBox(height: 50),
//                       Container(
//                         height: 200,
//                         child: PageView(
//                           controller: PageController(viewportFraction: 0.8),
//                           scrollDirection: Axis.horizontal,
//                           pageSnapping: true,
//                           children: <Widget>[
//                             Container(
//                               margin: const EdgeInsets.symmetric(horizontal: 8),
//                               color: Colors.redAccent,
//                               width: 100,
//                             ),
//                             Container(
//                                   margin: const EdgeInsets.symmetric(horizontal: 8),
//                                width: 50,
//                                  child:    RadarChart.dark(
//                                     ticks: ticks,
//                                  features: features,
//                                  data: data,
// ),
//                             ),
                  //       Container(
                  //         margin: const EdgeInsets.symmetric(horizontal: 8),
                  //         color: Colors.greenAccent,
                  //         width: 100,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(height: 20),
                  Text(
                    "How Much Would you rate yourself on fitness?? ${value1.toString().trim().split(".")[0]} %",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  new Slider(
                    value: value1,
                    min: 0,
                    max: 100,
                    activeColor: Colors.blue,
                    inactiveColor: Colors.redAccent,
                    onChanged: (value1) {
                      _onchanged1(value1);
                    },
                  ),

                  //                  // SizedBox(height: 20),
                  //                  Text("How Much Would you rate yourself on fitness?? ${value2.toString().trim().split(".")[0]} %", style: TextStyle(color: Colors.white, fontSize: 15),),
                  //                 new Slider(
                  //                   value: value2,min: 0,
                  //                   max: 100,activeColor: Colors.blue,
                  //                   inactiveColor: Colors.redAccent,onChanged: (value2){
                  //                     _onchanged2(value2);
                  //                                                       },
                  //                                                     ),
                  //                                                      SizedBox(height: 20),
                  //                  Text("How Much Would you rate yourself on fitness?? ${value3.toString().trim().split(".")[0]} %", style: TextStyle(color: Colors.white, fontSize: 15),),
                  //                 new Slider(
                  //                   value: value3,min: 0,
                  //                   max: 100,activeColor: Colors.blue,
                  //                   inactiveColor: Colors.redAccent,onChanged: (value3){

                  //                     _onchanged3(value3);
                  //                     _rate.save1();
                  //                                                       },
                  //                                                     ),
                  //                                        new Container(
                  //                                           padding: const EdgeInsets.only(left: 90,),
                  //                                          child: new RaisedButton(color: Colors.white,child: new Text('Save Rating',style: TextStyle(
                  //                                            color: Colors.black,
                  //                                          ),),
                  //                                            onPressed: (){
                  //                                            _rate.save1();

                  //                                            },
                  //                                          )  , ),
                  new Container(
                    height: 200,
                    width: 300,
                    padding: const EdgeInsets.only(
                        left: 30, right: 30, top: 35, bottom: 35),
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    child: RadarChart.dark(
                      ticks: ticks,
                      features: features,
                      data: data,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onchanged1(double value) {
    setState(() {
      //  value1 =value.round();
      _rate.value1 = value.round();
      print(value1);
    });
  }

  void _onchanged2(double value) {
    setState(() {
      value2 = value;
      _rate.value2 = value.round();
    });
  }

  void _onchanged3(double value) {
    setState(() {
      value3 = value;
      _rate.value3 = value.round();
    });
  }
}
