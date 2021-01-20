import 'package:first_app/E-Meeting/DashboardFinal.dart';
import 'package:connectivity/connectivity.dart';
import 'package:first_app/ForgotPassword/ChangPass.dart';
import 'package:first_app/ForgotPassword/postotp.dart';
import 'package:first_app/Models/rreporting.dart';
import 'package:first_app/Screens/Reportproblem.dart';
import 'package:first_app/main.dart';
import 'package:flutter/material.dart';
import 'package:first_app/Models/DynamDates.dart';
import 'package:flutter/rendering.dart';
import 'package:first_app/Models/DynamChecker.dart';
import 'package:first_app/Models/GetMinute.dart';
import 'package:first_app/Models/getgoals.dart';
import 'package:email_validator/email_validator.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

final Color backgroundColor = Colors.white;

class VerifyOtp extends StatelessWidget {
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
  bool _hasError = false;
  bool isLoading = true;
  bool isCollapsed = true;
  double screenWidth, screenHeight;
  String sstp;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;

  /// PinInputTextFormField form-key
  final GlobalKey<FormFieldState<String>> _formKey =
      GlobalKey<FormFieldState<String>>(debugLabel: '_formkey');

  /// Decorate the outside of the Pin.
  PinDecoration _pinDecoration = UnderlineDecoration(
    enteredColor: Colors.blue,
  );
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
                                    ("assets/Loogo.png"), height: 100,
                                    width: 100,
//assets/oofj.png
                                    // scale: _iconAnimation.value * 3,
                                    filterQuality: FilterQuality.high,
                                    // colorBlendMode: BlendMode.darken, (recentchange)
                                    //fit: BoxFit.scaleDown,
                                  ),
                                  // new FlutterLogo(
                                  //   size:_iconAnimation.value *100 ,
                                  // ), ]
                                  SizedBox(
                                    height: 20,
                                  ),
                                  new Text(
                                    "Please enter the OTP sent on your registered Email ID. ",
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
                                          alignment: Alignment.bottomCenter,
                                          child: Column(
                                            children: <Widget>[
                                              SizedBox(
                                                height: 12,
                                              ),
                                              SizedBox(
                                                height: 50,
                                                child: PinInputTextFormField(
                                                  pinLength: 5,
                                                  decoration: _pinDecoration,
                                                  textInputAction:
                                                      TextInputAction.go,
                                                  //  enabled: _enable,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  textCapitalization:
                                                      TextCapitalization
                                                          .characters,

                                                  validator: (pin) {
                                                    if (pin.isEmpty) {
                                                      setState(() {
                                                        _hasError = true;
                                                      });
                                                      return 'Otp cannot Be Empty empty.';
                                                    }
                                                    setState(() {
                                                      _hasError = false;
                                                    });
                                                    return null;
                                                  },
                                                  onSaved: (val) => setState(
                                                      () => sstp = val),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 16,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  RaisedButton(
                                                    onPressed: () async {
                                                      final form = _formKey1
                                                          .currentState;
                                                      if (form.validate() &&
                                                          form != null) {
                                                        form.save();
                                                        bool val =
                                                            await isConnected();

                                                        if (val) {
                                                          Dialogs
                                                              .showLoadingDialog(
                                                                  context,
                                                                  _keyLoader);
                                                          var vals = await _ots
                                                              .verify(sstp);
                                                          Navigator.of(
                                                                  _keyLoader
                                                                      .currentContext,
                                                                  rootNavigator:
                                                                      true)
                                                              .pop();

                                                          if (vals.toString() ==
                                                              "Success") {
                                                            Navigator.push(
                                                              context,
                                                              new MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          new ChangePass()),
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
                                                                        "Note !!  "),
                                                                    content:
                                                                        new Text(
                                                                      'Otp Is Incorrect , Please Enter Again',
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
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                      ),
                                                                      new FlatButton(
                                                                        child: new Text(
                                                                            "Cancel"),
                                                                        onPressed:
                                                                            () async {
                                                                          Navigator
                                                                              .pushReplacement(
                                                                            context,
                                                                            MaterialPageRoute(builder: (context) => new MyApp()),
                                                                          );
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
                                                    },
                                                    child: Text('Submit'),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    textColor: Colors.yellow,
                                                    color: _hasError
                                                        ? Colors.red
                                                        : Colors.black,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ))
                                ]),
                          ),
                        ]),
                  ))),
        ));
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
