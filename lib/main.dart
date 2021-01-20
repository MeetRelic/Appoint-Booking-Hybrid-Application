import 'package:first_app/E-Meeting/payment.dart';
import 'package:first_app/ForgotPassword/ChangPass.dart';
import 'package:first_app/ForgotPassword/VerifyOtp.dart';
import 'package:first_app/ForgotPassword/checkmail.dart';
import 'package:first_app/Models/verifyuser.dart';
import 'package:first_app/Screens/DevContact.dart';
import 'package:first_app/Screens/Reportproblem.dart';
import 'package:first_app/feedback.dart';

import 'package:password/password.dart';

import 'package:connectivity/connectivity.dart';
import 'package:first_app/Globalz.dart' as globals;
import 'package:email_validator/email_validator.dart';

import 'package:first_app/Models/Mandat.dart';
import 'package:first_app/Screens/Rating.dart';
import 'package:flutter/material.dart';

import 'E-Meeting/DashboardFinal.dart';

import 'Screens/registration.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: LoginPage(),
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  State createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  String emailAdd;
  String pass;
  String congrats = //after lets it will be in new line.
      "We appreciate you taking first step towards joyful life! Lets Set the Chakra in Motion !";
  final _mandat = Mandat();
  final _verify = Verify();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  AnimationController _iconAnimationController;
  Animation<double> _iconAnimation;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _iconAnimationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 400));
    _iconAnimation = new CurvedAnimation(
      parent: _iconAnimationController,
      curve: Curves.bounceOut,
    );
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return new Scaffold(
      backgroundColor: Colors.white,
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // new Image(
          //   image: new AssetImage("assets/preview.jpg"),
          //   fit: BoxFit.cover,
          //   color: Colors.black87,
          //   colorBlendMode: BlendMode.darken,
          // ),
          // new Container(
          //  child: Align(
          //    alignment: Alignment.bottomCenter,
          //  ),
          // ),

          new SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                  padding: const EdgeInsets.only(top: 45.0),
                ),
                new Image.asset(
                  ("assets/Loogo.png"),
//assets/oofj.png
                  scale: _iconAnimation.value * 3,
                  filterQuality: FilterQuality.high,
                  // colorBlendMode: BlendMode.darken, (recentchange)
                  //fit: BoxFit.scaleDown,
                ),
                // new FlutterLogo(
                //   size:_iconAnimation.value *100 ,
                // ),
                new Form(
                  key: _formKey,
                  child: Theme(
                    data: new ThemeData(
                        brightness: Brightness.light,
                        primarySwatch: Colors.teal,
                        inputDecorationTheme: new InputDecorationTheme(
                            labelStyle: new TextStyle(
                          color: Colors.teal,
                          fontSize: 20.0,
                        ))),
                    child: Container(
                      //constraints: BoxConstraints(minWidth: 230.0, minHeight: 25.0),
                      padding: const EdgeInsets.all(40.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new TextFormField(
                            decoration: new InputDecoration(
                              hintText: "Enter Email",
                              hintStyle: TextStyle(
                                  fontSize: 15.0, color: Colors.black),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please Enter Your Email Address';
                              } else if (!EmailValidator.validate(
                                  value.trim())) {
                                return 'Please Enter Proper Email Address';
                              }
                            },
                            onSaved: (val) => setState(() => emailAdd = val),
                            keyboardType: TextInputType.text,
                          ),
                          new TextFormField(
                            obscureText: true,
                            decoration: new InputDecoration(
                              hintText: "Enter Password",
                              hintStyle: TextStyle(
                                  fontSize: 15.0, color: Colors.black),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please Enter Your Password';
                              }
                            },
                            onSaved: (val) => setState(() => pass = val),
                            keyboardType: TextInputType.text,
                          ),
                          new Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                          ),
                          new FlatButton(
                              splashColor: Colors.white,
//                          textAlign: TextAlign.start,
                              child: Text(
                                ' SIGN IN ',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.yellow[500],
                                  fontFamily: 'Calibri',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              color: Colors.black87,
                              onPressed: () async {
                                final form = _formKey.currentState;
                                if (form.validate()) {
                                  form.save();
                                  globals.email = emailAdd.toLowerCase().trim();

//if and else here also for rting or dashboard first call method which gets data
                                  bool val = await isConnected();

                                  if (val) {
                                    Dialogs1.showLoadingDialog(
                                        context, _keyLoader);
                                    var hash = await _verify.isusercorrect();
// final password = 'Meet@123';
//    final algorithm = PBKDF2();
//    final hsh = Password.hash(password, algorithm);
// print(hsh);
                                    //   print(hash);
                                    if (hash.toString().contains("404")) {
                                      Navigator.pop(
                                        _keyLoader.currentContext,
                                      );
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            // return object of type Dialog
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(15))),
                                              title: new Text(" ERROR OCCURED"),
                                              content: new Text(
                                                'Please Try Again Later Or Inform Us ,By Clicking Ok.',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontFamily: 'Arial'),
                                              ),
                                              actions: <Widget>[
                                                new FlatButton(
                                                  child: new Text("OK"),
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              new ReportProblem()),
                                                    );
                                                    //ADD CLASS FOR REPORT PROBLEM SERVICE .
                                                    //.of(context).pop();
                                                  },
                                                ),
                                                new FlatButton(
                                                  child: new Text("Cancel"),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    //ADD CLASS FOR REPORT PROBLEM SERVICE .
                                                    //.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          });
                                    } else if (!hash
                                        .toString()
                                        .contains("Not valid")) {
                                      bool verify =
                                          Password.verify(pass.trim(), hash);
//bool verify=true;
                                      //    print(verify);

                                      if (verify) {
                                        var a = await _mandat.getmandat();
                                        //  print(globals.ratingstatus);
                                        if (globals.fdbk.contains("Yes")) {
                                          Navigator.pop(
                                            _keyLoader.currentContext,
                                          );
                                          Navigator.pushReplacement(
                                            context,
                                            new MaterialPageRoute(
                                                builder: (context) =>
                                                    new FDBck()),
                                          );
                                        } else if (globals.ratingstatus
                                                .trim()
                                                .contains("pend") &&
                                            a.toString().contains("Succes")) {
                                          Navigator.pop(
                                            _keyLoader.currentContext,
                                          );
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                // return object of type Dialog
                                                return AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  15))),
                                                  title:
                                                      new Text(" Greetings! "),
                                                  content: new Text(
                                                    'We appreciate you taking first step towards joyful life!\n\n Lets Set the Chakra in Motion !',
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        fontFamily: 'Arial'),
                                                  ),
                                                  actions: <Widget>[
                                                    new FlatButton(
                                                      child: new Text("Okay"),
                                                      onPressed: () {
                                                        Navigator
                                                            .pushReplacement(
                                                          context,
                                                          new MaterialPageRoute(
                                                              builder: (context) =>
                                                                  new MenuDashboardPage12()),
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                );
                                              });
                                        } else if (a
                                            .toString()
                                            .contains("Succes")) {
                                          Navigator.pop(
                                            _keyLoader.currentContext,
                                          );
                                          Navigator.pushReplacement(
                                            context,
                                            new MaterialPageRoute(
                                                builder: (context) =>
                                                    new DSB()),
                                          );
                                        }
                                      } else {
                                        Navigator.pop(
                                          _keyLoader.currentContext,
                                        );
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              // return object of type Dialog
                                              return AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                15))),
                                                title: new Text(" OOPS!! "),
                                                content: new Text(
                                                  'It Seems You Have Entered Incorrect Credentials, Please Rectify',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      fontFamily: 'Arial'),
                                                ),
                                                actions: <Widget>[
                                                  new FlatButton(
                                                    child: new Text("OK"),
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                new MyApp()),
                                                      );
                                                      //.of(context).pop();
                                                    },
                                                  ),
                                                ],
                                              );
                                            });
                                      }
                                    } else {
                                      Navigator.pop(
                                        _keyLoader.currentContext,
                                      );
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            // return object of type Dialog
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(15))),
                                              title: new Text(" OOPS!! "),
                                              content: new Text(
                                                'It Seems You Have Entered Incorrect Credentials, Please Rectify',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontFamily: 'Arial'),
                                              ),
                                              actions: <Widget>[
                                                new FlatButton(
                                                  child: new Text("OK"),
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              new MyApp()),
                                                    );
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
                                              "It Seems You Don't Have Active Internet Connection,Please turn on Internet To Proceed.",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontFamily: 'Arial'),
                                            ),
                                            actions: <Widget>[
                                              new FlatButton(
                                                child: new Text("OK"),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          );
                                        });
                                  }
                                }
                              }),
                          new Padding(
                            padding: const EdgeInsets.only(top: 9.0),
                          ),
                          new FlatButton(
                            child: Text(
                              'Forgot Password',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.green[800],
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            onPressed: () async {
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => new Checkmail()),
                              );
                              //CDAT  DFDBck
                              // );
                              //.of(context).pop(
                              // List firsts = await _ReceiveMinute.recMinute();
                              // print(firsts);
                              // Navigator.push(
                              //   context,
                              //   new MaterialPageRoute(
                              //       builder: (context) => new ViewMin(
                              //             firsmins: firsts,
                              //           )),
                              // );
                            },
                          ),

                          //MenuDashboardPage12
                          SizedBox(
                            height: 15.0,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'New User ?',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              new FlatButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) => new Register()),
                                    );
                                  },
                                  child: Text(
                                    'Register here',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.yellow[800],
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                    ),
                                  )),
                            ],
                          ),
                          Container(
                            height: 250,
                            width: 250,
                            alignment: Alignment.center,
                            child: Image.asset(
                              ("assets/Capdture.png"),
//assets/oofj.png
                              // height: 500,
                              // width: 500, fit: BoxFit.fitWidth,
                              // scale: _iconAnimation.value * 5,
                              filterQuality: FilterQuality.high,
                              // colorBlendMode: BlendMode.darken, (recentchange)
                              //fit: BoxFit.scaleDown,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
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

class RaisedGradientButton extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final double width;
  final double height;
  final Function onPressed;

  const RaisedGradientButton({
    Key key,
    @required this.child,
    this.gradient,
    this.width = 110.0,
    this.height = 40.0,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(gradient: gradient, boxShadow: [
        BoxShadow(
          color: Colors.grey[500],
          offset: Offset(0.0, 1.5),
          blurRadius: 1.5,
        ),
      ]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: onPressed,
            splashColor: Colors.redAccent,
            child: Center(
              child: child,
            )),
      ),
    );
  }
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

class Dialogs1 {
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
                          "Authenticating User....",
                          style: TextStyle(color: Colors.blueAccent),
                        )
                      ]),
                    )
                  ]));
        });
  }
}
