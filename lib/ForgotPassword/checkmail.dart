import 'package:first_app/ForgotPassword/VerifyOtp.dart';
import 'package:first_app/Globalz.dart' as globals;
import 'package:first_app/E-Meeting/DashboardFinal.dart';
import 'package:connectivity/connectivity.dart';
import 'package:first_app/ForgotPassword/postotp.dart';
import 'package:first_app/Models/rreporting.dart';
import 'package:first_app/Screens/Reportproblem.dart';
import 'package:flutter/material.dart';
import 'package:first_app/Models/DynamDates.dart';
import 'package:flutter/rendering.dart';
import 'package:first_app/Models/DynamChecker.dart';
import 'package:first_app/Models/GetMinute.dart';
import 'package:first_app/Models/getgoals.dart';
import 'package:email_validator/email_validator.dart';

final Color backgroundColor = Colors.white;

class Checkmail extends StatelessWidget {
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
  final _ots = PostOtp();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final _formKey1 = GlobalKey<FormState>();
  String suggestion = '';
  bool ratingslider = false;
  bool radiochecker = false;

  bool isLoading = true;
  bool isCollapsed = true;
  double screenWidth, screenHeight;
  String emailAdd;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
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
          dashboard(context),
        ],
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
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          physics: ClampingScrollPhysics(),
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Container(
                                padding: const EdgeInsets.only(top: 5.0),
                              ),
                              new Image.asset(
                                ("assets/Loogo.png"), height: 100, width: 100,
//assets/oofj.png
                                // scale: _iconAnimation.value * 3,
                                filterQuality: FilterQuality.high,
                                // colorBlendMode: BlendMode.darken, (recentchange)
                                //fit: BoxFit.scaleDown,
                              ),
                              // new FlutterLogo(
                              //   size:_iconAnimation.value *100 ,
                              // ), ]
                              new Text(
                                "Please Provide Email Id to Get OTP ",
                                textAlign: TextAlign.start,
                                style: TextStyle(fontSize: 15),
                              ),
                              new Form(
                                  key: _formKey1,
                                  child: Theme(
                                      data: new ThemeData(
                                          brightness: Brightness.light,
                                          primarySwatch: Colors.teal,
                                          inputDecorationTheme:
                                              new InputDecorationTheme(
                                                  labelStyle: new TextStyle(
                                            color: Colors.teal,
                                            fontSize: 20.0,
                                          ))),
                                      child: Container(
                                          //constraints: BoxConstraints(minWidth: 230.0, minHeight: 25.0),
                                          padding: const EdgeInsets.all(40.0),
                                          child: new Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                new TextFormField(
                                                  decoration:
                                                      new InputDecoration(
                                                    hintText: "Enter Email id",
                                                    hintStyle: TextStyle(
                                                        fontSize: 15.0,
                                                        color: Colors.black),
                                                  ),
                                                  validator: (value) {
                                                    if (value.isEmpty) {
                                                      return 'Please Enter Your Email Address';
                                                    } else if (!EmailValidator
                                                        .validate(
                                                            value.trim())) {
                                                      return 'Please Enter Proper Email Address';
                                                    }
                                                  },
                                                  onSaved: (val) => setState(
                                                      () => emailAdd = val),
                                                  keyboardType:
                                                      TextInputType.text,
                                                ),
                                                new Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 20.0),
                                                ),
                                                new FlatButton(
                                                    splashColor: Colors.white,
                                                    child: Text(
                                                      ' GET OTP ',
                                                      style: TextStyle(
                                                        fontSize: 16.0,
                                                        color:
                                                            Colors.yellow[500],
                                                        fontFamily: 'Calibri',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    color: Colors.black87,
                                                    onPressed: () async {
                                                      final form = _formKey1
                                                          .currentState;
                                                      if (form.validate()) {
                                                        form.save();
                                                        globals.email = emailAdd
                                                            .toLowerCase()
                                                            .toString();
                                                        bool val =
                                                            await isConnected();

                                                        if (val) {
                                                          Dialogs
                                                              .showLoadingDialog(
                                                                  context,
                                                                  _keyLoader);
                                                          var vals = await _ots
                                                              .sendotp(
                                                                  emailAdd);
                                                          print(vals);
                                                          Navigator.of(
                                                                  _keyLoader
                                                                      .currentContext,
                                                                  rootNavigator:
                                                                      true)
                                                              .pop();

                                                          if (vals
                                                              .toString()
                                                              .contains(
                                                                  "Success")) {
                                                            Navigator.push(
                                                              context,
                                                              new MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          new VerifyOtp()),
                                                            );
                                                          } else {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  // return object of type Dialog
                                                                  return AlertDialog(
                                                                    title: new Text(
                                                                        " ERROR - Please  Try Again!!  "),
                                                                    content:
                                                                        new Text(
                                                                      'Report Issue and we will assist. ',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'Arial'),
                                                                    ),
                                                                    actions: <
                                                                        Widget>[
                                                                      new FlatButton(
                                                                        child: new Text(
                                                                            "Okay"),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator
                                                                              .push(
                                                                            context,
                                                                            new MaterialPageRoute(builder: (context) => new ReportProblem()),
                                                                          );
                                                                        },
                                                                      ),
                                                                      new FlatButton(
                                                                        child: new Text(
                                                                            "Cancel"),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                      ),
                                                                    ],
                                                                  );
                                                                });
                                                          }
                                                        } else {
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                // return object of type Dialog
                                                                return AlertDialog(
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(15))),
                                                                  title: new Text(
                                                                      " OOPS!! "),
                                                                  content:
                                                                      new Text(
                                                                    "It Seems You Don't Have Active Internet Connection,Please turn on Internet To Proceed.",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Arial'),
                                                                  ),
                                                                  actions: <
                                                                      Widget>[
                                                                    new FlatButton(
                                                                      child: new Text(
                                                                          "OK"),
                                                                      onPressed:
                                                                          () {},
                                                                    ),
                                                                  ],
                                                                );
                                                              });
                                                        }
                                                      } else {}
                                                    })
                                              ])))),
                            ],
                          ),
                        ),
                      ]),
                ),
              ),
            )));
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
