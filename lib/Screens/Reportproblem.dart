import 'package:first_app/E-Meeting/DashboardFinal.dart';
import 'package:first_app/Globalz.dart' as globals;
import 'package:connectivity/connectivity.dart';
import 'package:first_app/Models/rreporting.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:first_app/Models/DynamDates.dart';
import 'package:flutter/rendering.dart';
import 'package:first_app/Models/DynamChecker.dart';
import 'package:first_app/Models/GetMinute.dart';
import 'package:first_app/Models/getgoals.dart';
import 'package:first_app/Screens/Reportproblem.dart';
import 'package:first_app/main.dart';
import 'package:first_app/Models/Bookdates.dart';
import 'package:first_app/Screens/customdates.dart';
import 'package:first_app/E-Meeting/EMeet.dart';

final Color backgroundColor = Colors.white;

class ReportProblem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meeting',
      home: E1Meet(),
    );
  }
}

class E1Meet extends StatefulWidget {
  @override
  _EM createState() => _EM();
}

class _EM extends State<E1Meet> with SingleTickerProviderStateMixin {
  var months;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final _formKey = GlobalKey<FormState>();
  String suggestion = '';
  bool ratingslider = false;
  bool radiochecker = false;
  final _fdbk = Rspond();
  final _checker = DynamChecker();
  final _getmin = GetMinute();
  final _getgaal = Getgoals();
  final _dates = DynamDates('');
  bool isLoading = true;

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
      appBar: _getIconAppBar(),
      backgroundColor: backgroundColor,
      body: Stack(
        children: <Widget>[
          dashboard(context),
        ],
      ),
    );
  }

  _getIconAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(50),
      child: Container(
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.white,
              Colors.white
              //  Colors.redAccent,
            ],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.menu),
                color: Colors.white,
                onPressed: () {
                  setState(() {
                    if (isCollapsed)
                      _controller.forward();
                    else
                      _controller.reverse();

                    isCollapsed = !isCollapsed;
                  });
                }),
            Text(
              "Report Issues",
              style: TextStyle(fontSize: 22),
            ),
            // Image(
            //   image: new AssetImage("assets/VD.jpg"),
            //   height: 40,
            //   width: 90,
            //   fit: BoxFit.fitHeight,
            // ),
            //IconButton(icon: new Image.asset("assets/VD.jpg"),iconSize: 25, onPressed: null),
            IconButton(
                icon: Icon(Icons.data_usage),
                color: Colors.white,
                onPressed: () {}),
          ],
        ),
      ),
    );
  }

  Widget dashboard(context) {
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.6 * screenWidth,
      right: isCollapsed ? 0 : -0.4 * screenWidth,
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
              //padding: const EdgeInsets.only(left: 16, right: 16, top: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 30),
                  new Text(
                    "Please Provide the Summary of Issue or Error Faced",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 15),
                  ),
                  Container(
                      child: Builder(
                          builder: (context) => Form(
                                key: _formKey,
                                child: Container(
                                  child: new TextFormField(
                                    maxLines: 10,
                                    maxLength: 250,
                                    decoration: InputDecoration(
                                        labelText: "Enter Issue Faced Here !!",
                                        labelStyle: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.black)),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter summary';
                                      }
                                    },
                                    onSaved: (val) =>
                                        setState(() => suggestion = val),
                                  ),
                                ),
                              ))),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                        child: new FlatButton(
                      child: Text('Send',
                          style: TextStyle(
                            fontSize: 17.0,
                            color: Colors.white,
                          )),
                      onPressed: () async {
                        bool val = await isConnected();
                        if (val) {
                          final form = _formKey.currentState;

                          if (form.validate()) {
                            form.save();
                            Dialogs.showLoadingDialog(context, _keyLoader);
                            var response = await _fdbk.sendreports(
                              suggestion,
                            );
                            Navigator.pop(
                              _keyLoader.currentContext,
                            );
                            if (response.contains("Success")) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    // return object of type Dialog
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                      title: new Text(" REPORTED !! "),
                                      content: new Text(
                                        'Your Reporting is Very Important to us we will work and consider good measures for it !!, Press Okay to Continue',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(fontFamily: 'Arial'),
                                      ),
                                      actions: <Widget>[
                                        new FlatButton(
                                          child: new Text("OKAY"),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              new MaterialPageRoute(
                                                  builder: (context) =>
                                                      new DSB()),
                                            );

                                            //.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            } else {}
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  // return object of type Dialog
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                    title: new Text(" OOPS!! "),
                                    content: new Text(
                                      'Seems You Have Not Actioned on First Two Mandatory Fields !!',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(fontFamily: 'Arial'),
                                    ),
                                    actions: <Widget>[
                                      new FlatButton(
                                        child: new Text("OK"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          //.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                });
                          }
                        } else {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                // return object of type Dialog
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  title: new Text(" OOPS!! "),
                                  content: new Text(
                                    'NO INTERNET CONNECTION , PLEASE CONNECT TO A NETWORK !!',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(fontFamily: 'Arial'),
                                  ),
                                  actions: <Widget>[
                                    new FlatButton(
                                      child: new Text("OK"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        //.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              });
                        }
                      },
                      color: Colors.black87,
                    )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<bool> isConnected() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  }
  return false;
}

class Dialogs {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  backgroundColor: Colors.black54,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Please Wait....",
                          style: TextStyle(color: Colors.blueAccent),
                        )
                      ]),
                    )
                  ]));
        });
  }
}

//                                                     void printWrapped(String text) {
//   final pattern = RegExp('.{500}'); // 800 is the size of each chunk
//   pattern.allMatches(text).forEach((match) => print(match.group(0)));
// }

//right code

// Response response = await http.get("http://10.0.2.2:8080/vivek/vdapi/getDates");
//    if (response.statusCode == 200) {
//printWrapped(response.body.toString());}
// var tagObjsJson = jsonDecode(response.body.toString())['Dates'] as List;
// if(tagObjsJson !=null){
//    List<Tag> tagObjs = tagObjsJson.map((tagJson) => Tag.fromJson(tagJson)).toList();

//print(tagObjs);}}
