import 'dart:async';
import 'dart:core';
import 'package:first_app/Screens/DevContact.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:connectivity/connectivity.dart';
import 'package:first_app/E-Meeting/payment.dart';
import 'package:first_app/Globalz.dart' as globals;
import 'package:first_app/E-Meeting/EmeetSlots.dart';
import 'package:first_app/Models/DateApi.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:first_app/Models/DynamDates.dart';
import 'package:first_app/Models/rating.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:demoji/demoji.dart';
import 'package:first_app/Models/DynamChecker.dart';
import 'package:first_app/Models/GetMinute.dart';
import 'package:first_app/Models/getgoals.dart';
import 'package:first_app/Screens/Reportproblem.dart';
import 'package:first_app/main.dart';

import 'package:first_app/E-Meeting/DashboardFinal.dart';

final Color backgroundColor = Colors.white;

class EM1 extends StatelessWidget {
  final String eml;
  final List tags;
  EM1({this.tags, this.eml});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meeting',
      home: EM1Meet(tags: tags, eml: eml),
    );
  }
}

class EM1Meet extends StatefulWidget {
  final List tags;
  final String eml;
  EM1Meet({this.tags, this.eml});
  @override
  _EM1 createState() => _EM1(tags: tags, eml: eml);
}

class _EM1 extends State<EM1Meet> with SingleTickerProviderStateMixin {
  _EM1({this.tags, this.eml});
  String eml;
  List tags;
  final _checker = DynamChecker();
  final _getmin = GetMinute();
  final _getgaal = Getgoals();
  final _dates = DynamDates('');
  bool _clicked;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final _mon = Month('');
  final _rate = Rating();
  final _datapi = DateApi;
  double value1 = 0.0;
  double value2 = 0.0;
  double value3 = 0.0;
  double value4 = 0.0;
  var selectedCurrency, selectedType;
  List date = new List();
  List slot1 = new List();
  List slot2 = new List();

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
          menu(context),
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
                color: Colors.black,
                onPressed: () {
                  setState(() {
                    if (isCollapsed)
                      _controller.forward();
                    else
                      _controller.reverse();

                    isCollapsed = !isCollapsed;
                  });
                }),
            Image(
              image: new AssetImage("assets/VD.jpg"),
              height: 40,
              width: 90,
              fit: BoxFit.fitHeight,
            ),
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

  Widget menu(context) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Padding(
          padding: const EdgeInsets.only(top: 0, right: 88.0),
          child: Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: <Widget>[
                  new Container(
                    padding: EdgeInsets.only(top: 05, right: 10),
                    child: new CircularProfileAvatar(
                      '',
                      //sets image path, it should be a URL string. default value is empty string, if path is empty it will display only initials
                      radius: 28, // sets radius, default 50.0
                      backgroundColor: Colors
                          .transparent, // sets background color, default Colors.white
                      borderWidth: 10, // sets border, default 0.0
                      initialsText: Text(
                        globals.initials,
                        style: TextStyle(fontSize: 19, color: Colors.yellow),
                      ), // sets initials text, set your own style, default Text('')
                      borderColor: Colors
                          .black, // sets border color, default Colors.white
                      elevation:
                          5.0, // sets elevation (shadow of the profile picture), default value is 0.0
                      foregroundColor: Colors.black.withOpacity(
                          0.5), //sets foreground colour, it works if showInitialTextAbovePicture = true , default Colors.transparent
                      cacheImage:
                          true, // allow widget to cache image against provided url
                      onTap: () {}, // sets on tap
                      showInitialTextAbovePicture:
                          false, // setting it true will show initials text above profile picture, default false
                    ),
                  ),
                  // Container(
                  //  child: new GFAvatar(
                  //    ,
                  //  ),

                  // ),
                  SizedBox(height: 8),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(globals.name.toUpperCase(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  SizedBox(height: 8),
                  // new SizedBox(height: 100,),

                  Align(
                    alignment: Alignment.center,
                    child: Container(
                        child: new FlatButton(
                      child: Row(
                        // Replace with a Row for horizontal icon + text
                        children: <Widget>[
                          Icon(Icons.home),
                          SizedBox(
                            width: 32,
                          ),
                          Text(
                            'HOME',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.black,
                            ),
                          ),
                        ],
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
                        ),
                  ),

                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: ClampingScrollPhysics(),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: new ExpansionTile(
                        leading: Icon(
                          FontAwesomeIcons.users,
                          color: Colors.black,
                          size: 18,
                        ),
                        title: Text(
                          'EVOKE' + Demoji.registered + ' MEETINGS',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        children: <Widget>[
                          Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.only(right: 39),
                                child: new FlatButton(
                                  child: Text(
                                    'E-Meeting',
                                    style: TextStyle(
                                      fontSize: 12.0, color: Colors.black,

                                      //fontWeight: FontWeight.bold,
                                      //decoration: TextDecoration.none,
                                    ),
                                  ),
                                  onPressed: () async {
                                    if (globals.meetcount == 0) {
                                      bool val = await isConnected();

                                      if (val) {
                                        Dialogs.showLoadingDialog(
                                            context, _keyLoader);
                                        List<String> asss =
                                            await _dates.getDatvals();
                                        asss = await _dates.convertvals(asss);
                                        Navigator.of(_keyLoader.currentContext,
                                                rootNavigator: true)
                                            .pop();

                                        Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) => new EM1(
                                                  tags: asss,
                                                  eml: globals.email)),
                                        );
                                      } else {
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
                                                  "It Seems You Don't Have Active Internet Connection,Please turn on Internet To Proceed.",
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      fontFamily: 'Arial'),
                                                ),
                                                actions: <Widget>[
                                                  new FlatButton(
                                                    child: new Text("OK"),
                                                    onPressed: () {},
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
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(15))),
                                              title: new Text(" Note "),
                                              content: new Text(
                                                "These Meeting has already been Completed , Press Okay To Book Further Meetings.",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontFamily: 'Arial'),
                                              ),
                                              actions: <Widget>[
                                                new FlatButton(
                                                    child: new Text("OKAY"),
                                                    onPressed: () async {
                                                      bool val =
                                                          await isConnected();

                                                      if (val) {
                                                        Dialogs
                                                            .showLoadingDialog(
                                                                context,
                                                                _keyLoader);
                                                        List<String> asss =
                                                            await _dates
                                                                .getDatvals();
                                                        asss = await _dates
                                                            .convertvals(asss);

                                                        Navigator.of(
                                                                _keyLoader
                                                                    .currentContext,
                                                                rootNavigator:
                                                                    true)
                                                            .pop();
                                                        if (globals.meetcount ==
                                                            0) {
                                                          Navigator.push(
                                                            context,
                                                            new MaterialPageRoute(
                                                                builder: (context) => new EM1(
                                                                    tags: asss,
                                                                    eml: globals
                                                                        .email)),
                                                          );
                                                        } else if (globals
                                                                .meetcount ==
                                                            1) {
                                                          bool valss =
                                                              await _checker
                                                                  .checkfees(1);

                                                          //    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
                                                          if (valss) {
                                                            Navigator.push(
                                                              context,
                                                              new MaterialPageRoute(
                                                                  builder: (context) => new EM1(
                                                                      tags:
                                                                          asss,
                                                                      eml: globals
                                                                          .email)),
                                                            );

                                                            //if already booked than popup meeting Already BBooked ,true than go to booking page.
                                                          } else {
                                                            //   //AlertBox that Admin has not Confirmed the Payment.
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  // return object of type Dialog
                                                                  return AlertDialog(
                                                                    title: new Text(
                                                                        " Please Note !!  "),
                                                                    content:
                                                                        new Text(
                                                                      'Payment has not yet been processed as mentioned in Letter of Engagement previously , To check the Payment Details Please Click Yes !! ',
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
                                                                            "YES"),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator
                                                                              .push(
                                                                            context,
                                                                            MaterialPageRoute(builder: (context) => new Payments()),
                                                                          );
                                                                        },
                                                                      ),
                                                                      new FlatButton(
                                                                        child: new Text(
                                                                            "NO"),
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
                                                        } else if (globals
                                                                .meetcount ==
                                                            2) {
                                                          bool valss =
                                                              await _checker
                                                                  .checkfees(2);

                                                          //    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
                                                          if (valss) {
                                                            Navigator.push(
                                                              context,
                                                              new MaterialPageRoute(
                                                                  builder: (context) => new EM1(
                                                                      tags:
                                                                          asss,
                                                                      eml: globals
                                                                          .email)),
                                                            );

                                                            //if already booked than popup meeting Already BBooked ,true than go to booking page.
                                                          } else {
                                                            //   //AlertBox that Admin has not Confirmed the Payment.
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  // return object of type Dialog
                                                                  return AlertDialog(
                                                                    title: new Text(
                                                                        " Please Note !!  "),
                                                                    content:
                                                                        new Text(
                                                                      'Payment has not yet been processed as mentioned in Letter of Engagement previously , To check the Payment Details Please Click Yes !! ',
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
                                                                            "YES"),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator
                                                                              .push(
                                                                            context,
                                                                            MaterialPageRoute(builder: (context) => new Payments()),
                                                                          );
                                                                        },
                                                                      ),
                                                                      new FlatButton(
                                                                        child: new Text(
                                                                            "NO"),
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
                                                        } else if (globals
                                                                .meetcount ==
                                                            3) {
                                                          bool valss =
                                                              await _checker
                                                                  .checkfees(3);

                                                          //    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
                                                          if (valss) {
                                                            Navigator.push(
                                                              context,
                                                              new MaterialPageRoute(
                                                                  builder: (context) => new EM1(
                                                                      tags:
                                                                          asss,
                                                                      eml: globals
                                                                          .email)),
                                                            );

                                                            //if already booked than popup meeting Already BBooked ,true than go to booking page.
                                                          } else {
                                                            //   //AlertBox that Admin has not Confirmed the Payment.
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  // return object of type Dialog
                                                                  return AlertDialog(
                                                                    title: new Text(
                                                                        " Please Note !!  "),
                                                                    content:
                                                                        new Text(
                                                                      'Payment has not yet been processed as mentioned in Letter of Engagement previously , To check the Payment Details Please Click Yes !! ',
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
                                                                            "YES"),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator
                                                                              .push(
                                                                            context,
                                                                            MaterialPageRoute(builder: (context) => new Payments()),
                                                                          );
                                                                        },
                                                                      ),
                                                                      new FlatButton(
                                                                        child: new Text(
                                                                            "NO"),
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
                                                        } else if (globals
                                                                .meetcount ==
                                                            4) {
                                                          bool valss =
                                                              await _checker
                                                                  .checkfees(4);

                                                          //    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
                                                          if (valss) {
                                                            Navigator.push(
                                                              context,
                                                              new MaterialPageRoute(
                                                                  builder: (context) => new EM1(
                                                                      tags:
                                                                          asss,
                                                                      eml: globals
                                                                          .email)),
                                                            );

                                                            //if already booked than popup meeting Already BBooked ,true than go to booking page.
                                                          } else {
                                                            //   //AlertBox that Admin has not Confirmed the Payment.
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  // return object of type Dialog
                                                                  return AlertDialog(
                                                                    title: new Text(
                                                                        " Please Note !!  "),
                                                                    content:
                                                                        new Text(
                                                                      'Payment has not yet been processed as mentioned in Letter of Engagement previously , To check the Payment Details Please Click Yes !! ',
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
                                                                            "YES"),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator
                                                                              .push(
                                                                            context,
                                                                            MaterialPageRoute(builder: (context) => new Payments()),
                                                                          );
                                                                        },
                                                                      ),
                                                                      new FlatButton(
                                                                        child: new Text(
                                                                            "NO"),
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
                                                        } else if (globals
                                                                .meetcount >
                                                            4) {
                                                          int fcount = globals
                                                                  .meetcount -
                                                              4;
                                                          bool valss =
                                                              await _checker
                                                                  .checkfees(
                                                                      fcount);

                                                          //    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
                                                          if (valss) {
                                                            Navigator.push(
                                                              context,
                                                              new MaterialPageRoute(
                                                                  builder: (context) => new EM1(
                                                                      tags:
                                                                          asss,
                                                                      eml: globals
                                                                          .email)),
                                                            );

                                                            //if already booked than popup meeting Already BBooked ,true than go to booking page.
                                                          } else {
                                                            //   //AlertBox that Admin has not Confirmed the Payment.
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  // return object of type Dialog
                                                                  return AlertDialog(
                                                                    title: new Text(
                                                                        " Please Note !!  "),
                                                                    content:
                                                                        new Text(
                                                                      'Payment has not yet been processed as mentioned in Letter of Engagement previously , To check the Payment Details Please Click Yes !! ',
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
                                                                            "YES"),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator
                                                                              .push(
                                                                            context,
                                                                            MaterialPageRoute(builder: (context) => new Payments()),
                                                                          );
                                                                        },
                                                                      ),
                                                                      new FlatButton(
                                                                        child: new Text(
                                                                            "NO"),
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
                                                                    child:
                                                                        new Text(
                                                                            "OK"),
                                                                    onPressed:
                                                                        () {},
                                                                  ),
                                                                ],
                                                              );
                                                            });
                                                      }
                                                    }),
                                              ],
                                            );
                                          });

                                      //alertbox
                                    }
                                  },
                                  //style: TextStyle(color: Colors.white,fontSize: 20,
                                ),
                              )
                              //     new SizedBox(height: 2,),
                              ),
                          Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.only(right: 39),
                                child: new FlatButton(
                                  child: Text(
                                    'V-Meeting',
                                    style: TextStyle(
                                      fontSize: 12.0, color: Colors.black,

                                      //fontWeight: FontWeight.bold,
                                      //decoration: TextDecoration.none,
                                    ),
                                  ),
                                  onPressed: () async {
                                    if (globals.meetcount == 1) {
                                      bool val = await isConnected();

                                      if (val) {
                                        Dialogs.showLoadingDialog(
                                            context, _keyLoader);
                                        List<String> asss =
                                            await _dates.getDatvals();
                                        asss = await _dates.convertvals(asss);

                                        Navigator.of(_keyLoader.currentContext,
                                                rootNavigator: true)
                                            .pop();

                                        bool valss =
                                            await _checker.checkfees(1);

                                        //    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
                                        if (valss) {
                                          Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                                builder: (context) => new EM1(
                                                    tags: asss,
                                                    eml: globals.email)),
                                          );

                                          //if already booked than popup meeting Already BBooked ,true than go to booking page.
                                        } else {
                                          //   //AlertBox that Admin has not Confirmed the Payment.
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                // return object of type Dialog
                                                return AlertDialog(
                                                  title: new Text(
                                                      " Please Note !!  "),
                                                  content: new Text(
                                                    'Payment has not yet been processed as mentioned in Letter of Engagement previously , To check the Payment Details Please Click Yes !! ',
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        fontFamily: 'Arial'),
                                                  ),
                                                  actions: <Widget>[
                                                    new FlatButton(
                                                      child: new Text("YES"),
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  new Payments()),
                                                        );
                                                      },
                                                    ),
                                                    new FlatButton(
                                                      child: new Text("NO"),
                                                      onPressed: () {
                                                        Navigator.pop(context);
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
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                15))),
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
                                                    onPressed: () {},
                                                  ),
                                                ],
                                              );
                                            });
                                      }
                                    } else {
                                      String texst =
                                          await _dates.getlivetest(1);
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            // return object of type Dialog
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(15))),
                                              title: new Text(
                                                  " V Meeting Completed !! "),
                                              content: new Text(
                                                texst,
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontFamily: 'Arial'),
                                              ),
                                              actions: <Widget>[
                                                new FlatButton(
                                                    child: new Text("OKAY"),
                                                    onPressed: () async {
                                                      bool val =
                                                          await isConnected();

                                                      if (val) {
                                                        Dialogs
                                                            .showLoadingDialog(
                                                                context,
                                                                _keyLoader);
                                                        List<String> asss =
                                                            await _dates
                                                                .getDatvals();
                                                        asss = await _dates
                                                            .convertvals(asss);

                                                        Navigator.of(
                                                                _keyLoader
                                                                    .currentContext,
                                                                rootNavigator:
                                                                    true)
                                                            .pop();
                                                        if (globals.meetcount ==
                                                            0) {
                                                          Navigator.push(
                                                            context,
                                                            new MaterialPageRoute(
                                                                builder: (context) => new EM1(
                                                                    tags: asss,
                                                                    eml: globals
                                                                        .email)),
                                                          );
                                                        } else if (globals
                                                                .meetcount ==
                                                            1) {
                                                          bool valss =
                                                              await _checker
                                                                  .checkfees(1);

                                                          //    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
                                                          if (valss) {
                                                            Navigator.push(
                                                              context,
                                                              new MaterialPageRoute(
                                                                  builder: (context) => new EM1(
                                                                      tags:
                                                                          asss,
                                                                      eml: globals
                                                                          .email)),
                                                            );

                                                            //if already booked than popup meeting Already BBooked ,true than go to booking page.
                                                          } else {
                                                            //   //AlertBox that Admin has not Confirmed the Payment.
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  // return object of type Dialog
                                                                  return AlertDialog(
                                                                    title: new Text(
                                                                        " Please Note !!  "),
                                                                    content:
                                                                        new Text(
                                                                      'Payment has not yet been processed as mentioned in Letter of Engagement previously , To check the Payment Details Please Click Yes !! ',
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
                                                                            "YES"),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator
                                                                              .push(
                                                                            context,
                                                                            MaterialPageRoute(builder: (context) => new Payments()),
                                                                          );
                                                                        },
                                                                      ),
                                                                      new FlatButton(
                                                                        child: new Text(
                                                                            "NO"),
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
                                                        } else if (globals
                                                                .meetcount ==
                                                            2) {
                                                          bool valss =
                                                              await _checker
                                                                  .checkfees(2);

                                                          //    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
                                                          if (valss) {
                                                            Navigator.push(
                                                              context,
                                                              new MaterialPageRoute(
                                                                  builder: (context) => new EM1(
                                                                      tags:
                                                                          asss,
                                                                      eml: globals
                                                                          .email)),
                                                            );

                                                            //if already booked than popup meeting Already BBooked ,true than go to booking page.
                                                          } else {
                                                            //   //AlertBox that Admin has not Confirmed the Payment.
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  // return object of type Dialog
                                                                  return AlertDialog(
                                                                    title: new Text(
                                                                        " Please Note !!  "),
                                                                    content:
                                                                        new Text(
                                                                      'Payment has not yet been processed as mentioned in Letter of Engagement previously , To check the Payment Details Please Click Yes !! ',
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
                                                                            "YES"),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator
                                                                              .push(
                                                                            context,
                                                                            MaterialPageRoute(builder: (context) => new Payments()),
                                                                          );
                                                                        },
                                                                      ),
                                                                      new FlatButton(
                                                                        child: new Text(
                                                                            "NO"),
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
                                                        } else if (globals
                                                                .meetcount ==
                                                            3) {
                                                          bool valss =
                                                              await _checker
                                                                  .checkfees(3);

                                                          //    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
                                                          if (valss) {
                                                            Navigator.push(
                                                              context,
                                                              new MaterialPageRoute(
                                                                  builder: (context) => new EM1(
                                                                      tags:
                                                                          asss,
                                                                      eml: globals
                                                                          .email)),
                                                            );

                                                            //if already booked than popup meeting Already BBooked ,true than go to booking page.
                                                          } else {
                                                            //   //AlertBox that Admin has not Confirmed the Payment.
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  // return object of type Dialog
                                                                  return AlertDialog(
                                                                    title: new Text(
                                                                        " Please Note !!  "),
                                                                    content:
                                                                        new Text(
                                                                      'Payment has not yet been processed as mentioned in Letter of Engagement previously , To check the Payment Details Please Click Yes !! ',
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
                                                                            "YES"),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator
                                                                              .push(
                                                                            context,
                                                                            MaterialPageRoute(builder: (context) => new Payments()),
                                                                          );
                                                                        },
                                                                      ),
                                                                      new FlatButton(
                                                                        child: new Text(
                                                                            "NO"),
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
                                                        } else if (globals
                                                                .meetcount ==
                                                            4) {
                                                          bool valss =
                                                              await _checker
                                                                  .checkfees(4);

                                                          //    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
                                                          if (valss) {
                                                            Navigator.push(
                                                              context,
                                                              new MaterialPageRoute(
                                                                  builder: (context) => new EM1(
                                                                      tags:
                                                                          asss,
                                                                      eml: globals
                                                                          .email)),
                                                            );

                                                            //if already booked than popup meeting Already BBooked ,true than go to booking page.
                                                          } else {
                                                            //   //AlertBox that Admin has not Confirmed the Payment.
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  // return object of type Dialog
                                                                  return AlertDialog(
                                                                    title: new Text(
                                                                        " Please Note !!  "),
                                                                    content:
                                                                        new Text(
                                                                      'Payment has not yet been processed as mentioned in Letter of Engagement previously , To check the Payment Details Please Click Yes !! ',
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
                                                                            "YES"),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator
                                                                              .push(
                                                                            context,
                                                                            MaterialPageRoute(builder: (context) => new Payments()),
                                                                          );
                                                                        },
                                                                      ),
                                                                      new FlatButton(
                                                                        child: new Text(
                                                                            "NO"),
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
                                                        } else if (globals
                                                                .meetcount >
                                                            4) {
                                                          int fcount = globals
                                                                  .meetcount -
                                                              4;
                                                          bool valss =
                                                              await _checker
                                                                  .checkfees(
                                                                      fcount);

                                                          //    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
                                                          if (valss) {
                                                            Navigator.push(
                                                              context,
                                                              new MaterialPageRoute(
                                                                  builder: (context) => new EM1(
                                                                      tags:
                                                                          asss,
                                                                      eml: globals
                                                                          .email)),
                                                            );

                                                            //if already booked than popup meeting Already BBooked ,true than go to booking page.
                                                          } else {
                                                            //   //AlertBox that Admin has not Confirmed the Payment.
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  // return object of type Dialog
                                                                  return AlertDialog(
                                                                    title: new Text(
                                                                        " Please Note !!  "),
                                                                    content:
                                                                        new Text(
                                                                      'Payment has not yet been processed as mentioned in Letter of Engagement previously , To check the Payment Details Please Click Yes !! ',
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
                                                                            "YES"),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator
                                                                              .push(
                                                                            context,
                                                                            MaterialPageRoute(builder: (context) => new Payments()),
                                                                          );
                                                                        },
                                                                      ),
                                                                      new FlatButton(
                                                                        child: new Text(
                                                                            "NO"),
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
                                                                    child:
                                                                        new Text(
                                                                            "OK"),
                                                                    onPressed:
                                                                        () {},
                                                                  ),
                                                                ],
                                                              );
                                                            });
                                                      }
                                                    }),
                                              ],
                                            );
                                          });
                                    }
                                  }, //style: TextStyle(color: Colors.white,fontSize: 20,
                                ),
                              )
                              //     new SizedBox(height: 2,),
                              ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.only(right: 39),
                              child: new FlatButton(
                                child: Text(
                                  'O-Meeting',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.black,
                                  ),
                                ),
                                onPressed: () async {
                                  if (globals.meetcount == 2) {
                                    bool val = await isConnected();

                                    if (val) {
                                      Dialogs.showLoadingDialog(
                                          context, _keyLoader);
                                      List<String> asss =
                                          await _dates.getDatvals();
                                      asss = await _dates.convertvals(asss);

                                      Navigator.of(_keyLoader.currentContext,
                                              rootNavigator: true)
                                          .pop();

                                      bool valss = await _checker.checkfees(2);

                                      //    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
                                      if (valss) {
                                        Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) => new EM1(
                                                  tags: asss,
                                                  eml: globals.email)),
                                        );

                                        //if already booked than popup meeting Already BBooked ,true than go to booking page.
                                      } else {
                                        //   //AlertBox that Admin has not Confirmed the Payment.
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              // return object of type Dialog
                                              return AlertDialog(
                                                title: new Text(
                                                    " Please Note !!  "),
                                                content: new Text(
                                                  'Payment has not yet been processed as mentioned in Letter of Engagement previously , To check the Payment Details Please Click Yes !! ',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      fontFamily: 'Arial'),
                                                ),
                                                actions: <Widget>[
                                                  new FlatButton(
                                                    child: new Text("YES"),
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                new Payments()),
                                                      );
                                                    },
                                                  ),
                                                  new FlatButton(
                                                    child: new Text("NO"),
                                                    onPressed: () {
                                                      Navigator.pop(context);
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
                                                  borderRadius:
                                                      BorderRadius.all(
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
                                                  onPressed: () {},
                                                ),
                                              ],
                                            );
                                          });
                                    }
                                  } else {
                                    String texst = await _dates.getlivetest(2);
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          // return object of type Dialog
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15))),
                                            title: new Text(" Note "),
                                            content: new Text(
                                              texst,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontFamily: 'Arial'),
                                            ),
                                            actions: <Widget>[
                                              new FlatButton(
                                                  child: new Text("OKAY"),
                                                  onPressed: () async {
                                                    bool val =
                                                        await isConnected();

                                                    if (val) {
                                                      Dialogs.showLoadingDialog(
                                                          context, _keyLoader);
                                                      List<String> asss =
                                                          await _dates
                                                              .getDatvals();
                                                      asss = await _dates
                                                          .convertvals(asss);

                                                      Navigator.of(
                                                              _keyLoader
                                                                  .currentContext,
                                                              rootNavigator:
                                                                  true)
                                                          .pop();
                                                      if (globals.meetcount ==
                                                          0) {
                                                        Navigator.push(
                                                          context,
                                                          new MaterialPageRoute(
                                                              builder: (context) =>
                                                                  new EM1(
                                                                      tags:
                                                                          asss,
                                                                      eml: globals
                                                                          .email)),
                                                        );
                                                      } else if (globals
                                                              .meetcount ==
                                                          1) {
                                                        bool valss =
                                                            await _checker
                                                                .checkfees(1);

                                                        //    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
                                                        if (valss) {
                                                          Navigator.push(
                                                            context,
                                                            new MaterialPageRoute(
                                                                builder: (context) => new EM1(
                                                                    tags: asss,
                                                                    eml: globals
                                                                        .email)),
                                                          );

                                                          //if already booked than popup meeting Already BBooked ,true than go to booking page.
                                                        } else {
                                                          //   //AlertBox that Admin has not Confirmed the Payment.
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                // return object of type Dialog
                                                                return AlertDialog(
                                                                  title: new Text(
                                                                      " Please Note !!  "),
                                                                  content:
                                                                      new Text(
                                                                    'Payment has not yet been processed as mentioned in Letter of Engagement previously , To check the Payment Details Please Click Yes !! ',
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
                                                                          "YES"),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator
                                                                            .push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (context) => new Payments()),
                                                                        );
                                                                      },
                                                                    ),
                                                                    new FlatButton(
                                                                      child: new Text(
                                                                          "NO"),
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
                                                      } else if (globals
                                                              .meetcount ==
                                                          2) {
                                                        bool valss =
                                                            await _checker
                                                                .checkfees(2);

                                                        //    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
                                                        if (valss) {
                                                          Navigator.push(
                                                            context,
                                                            new MaterialPageRoute(
                                                                builder: (context) => new EM1(
                                                                    tags: asss,
                                                                    eml: globals
                                                                        .email)),
                                                          );

                                                          //if already booked than popup meeting Already BBooked ,true than go to booking page.
                                                        } else {
                                                          //   //AlertBox that Admin has not Confirmed the Payment.
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                // return object of type Dialog
                                                                return AlertDialog(
                                                                  title: new Text(
                                                                      " Please Note !!  "),
                                                                  content:
                                                                      new Text(
                                                                    'Payment has not yet been processed as mentioned in Letter of Engagement previously , To check the Payment Details Please Click Yes !! ',
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
                                                                          "YES"),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator
                                                                            .push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (context) => new Payments()),
                                                                        );
                                                                      },
                                                                    ),
                                                                    new FlatButton(
                                                                      child: new Text(
                                                                          "NO"),
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
                                                      } else if (globals
                                                              .meetcount ==
                                                          3) {
                                                        bool valss =
                                                            await _checker
                                                                .checkfees(3);

                                                        //    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
                                                        if (valss) {
                                                          Navigator.push(
                                                            context,
                                                            new MaterialPageRoute(
                                                                builder: (context) => new EM1(
                                                                    tags: asss,
                                                                    eml: globals
                                                                        .email)),
                                                          );

                                                          //if already booked than popup meeting Already BBooked ,true than go to booking page.
                                                        } else {
                                                          //   //AlertBox that Admin has not Confirmed the Payment.
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                // return object of type Dialog
                                                                return AlertDialog(
                                                                  title: new Text(
                                                                      " Please Note !!  "),
                                                                  content:
                                                                      new Text(
                                                                    'Payment has not yet been processed as mentioned in Letter of Engagement previously , To check the Payment Details Please Click Yes !! ',
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
                                                                          "YES"),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator
                                                                            .push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (context) => new Payments()),
                                                                        );
                                                                      },
                                                                    ),
                                                                    new FlatButton(
                                                                      child: new Text(
                                                                          "NO"),
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
                                                      } else if (globals
                                                              .meetcount ==
                                                          4) {
                                                        bool valss =
                                                            await _checker
                                                                .checkfees(4);

                                                        //    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
                                                        if (valss) {
                                                          Navigator.push(
                                                            context,
                                                            new MaterialPageRoute(
                                                                builder: (context) => new EM1(
                                                                    tags: asss,
                                                                    eml: globals
                                                                        .email)),
                                                          );

                                                          //if already booked than popup meeting Already BBooked ,true than go to booking page.
                                                        } else {
                                                          //   //AlertBox that Admin has not Confirmed the Payment.
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                // return object of type Dialog
                                                                return AlertDialog(
                                                                  title: new Text(
                                                                      " Please Note !!  "),
                                                                  content:
                                                                      new Text(
                                                                    'Payment has not yet been processed as mentioned in Letter of Engagement previously , To check the Payment Details Please Click Yes !! ',
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
                                                                          "YES"),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator
                                                                            .push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (context) => new Payments()),
                                                                        );
                                                                      },
                                                                    ),
                                                                    new FlatButton(
                                                                      child: new Text(
                                                                          "NO"),
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
                                                      } else if (globals
                                                              .meetcount >
                                                          4) {
                                                        int fcount =
                                                            globals.meetcount -
                                                                4;
                                                        bool valss =
                                                            await _checker
                                                                .checkfees(
                                                                    fcount);

                                                        //    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
                                                        if (valss) {
                                                          Navigator.push(
                                                            context,
                                                            new MaterialPageRoute(
                                                                builder: (context) => new EM1(
                                                                    tags: asss,
                                                                    eml: globals
                                                                        .email)),
                                                          );

                                                          //if already booked than popup meeting Already BBooked ,true than go to booking page.
                                                        } else {
                                                          //   //AlertBox that Admin has not Confirmed the Payment.
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                // return object of type Dialog
                                                                return AlertDialog(
                                                                  title: new Text(
                                                                      " Please Note !!  "),
                                                                  content:
                                                                      new Text(
                                                                    'Payment has not yet been processed as mentioned in Letter of Engagement previously , To check the Payment Details Please Click Yes !! ',
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
                                                                          "YES"),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator
                                                                            .push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (context) => new Payments()),
                                                                        );
                                                                      },
                                                                    ),
                                                                    new FlatButton(
                                                                      child: new Text(
                                                                          "NO"),
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
                                                      }
                                                    } else {
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            // return object of type Dialog
                                                            return AlertDialog(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              15))),
                                                              title: new Text(
                                                                  " OOPS!! "),
                                                              content: new Text(
                                                                "It Seems You Don't Have Active Internet Connection,Please turn on Internet To Proceed.",
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Arial'),
                                                              ),
                                                              actions: <Widget>[
                                                                new FlatButton(
                                                                  child:
                                                                      new Text(
                                                                          "OK"),
                                                                  onPressed:
                                                                      () {},
                                                                ),
                                                              ],
                                                            );
                                                          });
                                                    }
                                                  }),
                                            ],
                                          );
                                        });
                                  }
                                },
                                //style: TextStyle(color: Colors.white,fontSize: 20,
                              ),
                            ),
                            //     new SizedBox(height: 2,),
                          ),
                          Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.only(right: 39),
                                child: new FlatButton(
                                  child: Text(
                                    'K-Meeting',
                                    style: TextStyle(
                                      fontSize: 12.0, color: Colors.black,

                                      //fontWeight: FontWeight.bold,
                                      //decoration: TextDecoration.none,
                                    ),
                                  ),
                                  onPressed: () async {
                                    if (globals.meetcount == 3) {
                                      bool val = await isConnected();

                                      if (val) {
                                        Dialogs.showLoadingDialog(
                                            context, _keyLoader);
                                        List<String> asss =
                                            await _dates.getDatvals();
                                        asss = await _dates.convertvals(asss);

                                        Navigator.of(_keyLoader.currentContext,
                                                rootNavigator: true)
                                            .pop();

                                        bool valss =
                                            await _checker.checkfees(3);

                                        //    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
                                        if (valss) {
                                          Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                                builder: (context) => new EM1(
                                                    tags: asss,
                                                    eml: globals.email)),
                                          );

                                          //if already booked than popup meeting Already BBooked ,true than go to booking page.
                                        } else {
                                          //   //AlertBox that Admin has not Confirmed the Payment.
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                // return object of type Dialog
                                                return AlertDialog(
                                                  title: new Text(
                                                      " Please Note !!  "),
                                                  content: new Text(
                                                    'Payment has not yet been processed as mentioned in Letter of Engagement previously , To check the Payment Details Please Click Yes !! ',
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        fontFamily: 'Arial'),
                                                  ),
                                                  actions: <Widget>[
                                                    new FlatButton(
                                                      child: new Text("YES"),
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  new Payments()),
                                                        );
                                                      },
                                                    ),
                                                    new FlatButton(
                                                      child: new Text("NO"),
                                                      onPressed: () {
                                                        Navigator.pop(context);
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
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                15))),
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
                                                    onPressed: () {},
                                                  ),
                                                ],
                                              );
                                            });
                                      }
                                    } else {
                                      String texst =
                                          await _dates.getlivetest(3);
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            // return object of type Dialog
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(15))),
                                              title: new Text(" Note!! "),
                                              content: new Text(
                                                texst,
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontFamily: 'Arial'),
                                              ),
                                              actions: <Widget>[
                                                new FlatButton(
                                                    child: new Text("OKAY"),
                                                    onPressed: () async {
                                                      bool val =
                                                          await isConnected();

                                                      if (val) {
                                                        Dialogs
                                                            .showLoadingDialog(
                                                                context,
                                                                _keyLoader);
                                                        List<String> asss =
                                                            await _dates
                                                                .getDatvals();
                                                        asss = await _dates
                                                            .convertvals(asss);

                                                        Navigator.of(
                                                                _keyLoader
                                                                    .currentContext,
                                                                rootNavigator:
                                                                    true)
                                                            .pop();
                                                        if (globals.meetcount ==
                                                            0) {
                                                          Navigator.push(
                                                            context,
                                                            new MaterialPageRoute(
                                                                builder: (context) => new EM1(
                                                                    tags: asss,
                                                                    eml: globals
                                                                        .email)),
                                                          );
                                                        } else if (globals
                                                                .meetcount ==
                                                            1) {
                                                          bool valss =
                                                              await _checker
                                                                  .checkfees(1);

                                                          //    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
                                                          if (valss) {
                                                            Navigator.push(
                                                              context,
                                                              new MaterialPageRoute(
                                                                  builder: (context) => new EM1(
                                                                      tags:
                                                                          asss,
                                                                      eml: globals
                                                                          .email)),
                                                            );

                                                            //if already booked than popup meeting Already BBooked ,true than go to booking page.
                                                          } else {
                                                            //   //AlertBox that Admin has not Confirmed the Payment.
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  // return object of type Dialog
                                                                  return AlertDialog(
                                                                    title: new Text(
                                                                        " Please Note !!  "),
                                                                    content:
                                                                        new Text(
                                                                      'Payment has not yet been processed as mentioned in Letter of Engagement previously , To check the Payment Details Please Click Yes !! ',
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
                                                                            "YES"),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator
                                                                              .push(
                                                                            context,
                                                                            MaterialPageRoute(builder: (context) => new Payments()),
                                                                          );
                                                                        },
                                                                      ),
                                                                      new FlatButton(
                                                                        child: new Text(
                                                                            "NO"),
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
                                                        } else if (globals
                                                                .meetcount ==
                                                            2) {
                                                          bool valss =
                                                              await _checker
                                                                  .checkfees(2);

                                                          //    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
                                                          if (valss) {
                                                            Navigator.push(
                                                              context,
                                                              new MaterialPageRoute(
                                                                  builder: (context) => new EM1(
                                                                      tags:
                                                                          asss,
                                                                      eml: globals
                                                                          .email)),
                                                            );

                                                            //if already booked than popup meeting Already BBooked ,true than go to booking page.
                                                          } else {
                                                            //   //AlertBox that Admin has not Confirmed the Payment.
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  // return object of type Dialog
                                                                  return AlertDialog(
                                                                    title: new Text(
                                                                        " Please Note !!  "),
                                                                    content:
                                                                        new Text(
                                                                      'Payment has not yet been processed as mentioned in Letter of Engagement previously , To check the Payment Details Please Click Yes !! ',
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
                                                                            "YES"),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator
                                                                              .push(
                                                                            context,
                                                                            MaterialPageRoute(builder: (context) => new Payments()),
                                                                          );
                                                                        },
                                                                      ),
                                                                      new FlatButton(
                                                                        child: new Text(
                                                                            "NO"),
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
                                                        } else if (globals
                                                                .meetcount ==
                                                            3) {
                                                          bool valss =
                                                              await _checker
                                                                  .checkfees(3);

                                                          //    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
                                                          if (valss) {
                                                            Navigator.push(
                                                              context,
                                                              new MaterialPageRoute(
                                                                  builder: (context) => new EM1(
                                                                      tags:
                                                                          asss,
                                                                      eml: globals
                                                                          .email)),
                                                            );

                                                            //if already booked than popup meeting Already BBooked ,true than go to booking page.
                                                          } else {
                                                            //   //AlertBox that Admin has not Confirmed the Payment.
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  // return object of type Dialog
                                                                  return AlertDialog(
                                                                    title: new Text(
                                                                        " Please Note !!  "),
                                                                    content:
                                                                        new Text(
                                                                      'Payment has not yet been processed as mentioned in Letter of Engagement previously , To check the Payment Details Please Click Yes !! ',
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
                                                                            "YES"),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator
                                                                              .push(
                                                                            context,
                                                                            MaterialPageRoute(builder: (context) => new Payments()),
                                                                          );
                                                                        },
                                                                      ),
                                                                      new FlatButton(
                                                                        child: new Text(
                                                                            "NO"),
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
                                                        } else if (globals
                                                                .meetcount ==
                                                            4) {
                                                          bool valss =
                                                              await _checker
                                                                  .checkfees(4);

                                                          //    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
                                                          if (valss) {
                                                            Navigator.push(
                                                              context,
                                                              new MaterialPageRoute(
                                                                  builder: (context) => new EM1(
                                                                      tags:
                                                                          asss,
                                                                      eml: globals
                                                                          .email)),
                                                            );

                                                            //if already booked than popup meeting Already BBooked ,true than go to booking page.
                                                          } else {
                                                            //   //AlertBox that Admin has not Confirmed the Payment.
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  // return object of type Dialog
                                                                  return AlertDialog(
                                                                    title: new Text(
                                                                        " Please Note !!  "),
                                                                    content:
                                                                        new Text(
                                                                      'Payment has not yet been processed as mentioned in Letter of Engagement previously , To check the Payment Details Please Click Yes !! ',
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
                                                                            "YES"),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator
                                                                              .push(
                                                                            context,
                                                                            MaterialPageRoute(builder: (context) => new Payments()),
                                                                          );
                                                                        },
                                                                      ),
                                                                      new FlatButton(
                                                                        child: new Text(
                                                                            "NO"),
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
                                                        } else if (globals
                                                                .meetcount >
                                                            4) {
                                                          int fcount = globals
                                                                  .meetcount -
                                                              4;
                                                          bool valss =
                                                              await _checker
                                                                  .checkfees(
                                                                      fcount);

                                                          //    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
                                                          if (valss) {
                                                            Navigator.push(
                                                              context,
                                                              new MaterialPageRoute(
                                                                  builder: (context) => new EM1(
                                                                      tags:
                                                                          asss,
                                                                      eml: globals
                                                                          .email)),
                                                            );

                                                            //if already booked than popup meeting Already BBooked ,true than go to booking page.
                                                          } else {
                                                            //   //AlertBox that Admin has not Confirmed the Payment.
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  // return object of type Dialog
                                                                  return AlertDialog(
                                                                    title: new Text(
                                                                        " Please Note !!  "),
                                                                    content:
                                                                        new Text(
                                                                      'Payment has not yet been processed as mentioned in Letter of Engagement previously , To check the Payment Details Please Click Yes !! ',
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
                                                                            "YES"),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator
                                                                              .push(
                                                                            context,
                                                                            MaterialPageRoute(builder: (context) => new Payments()),
                                                                          );
                                                                        },
                                                                      ),
                                                                      new FlatButton(
                                                                        child: new Text(
                                                                            "NO"),
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
                                                                    child:
                                                                        new Text(
                                                                            "OK"),
                                                                    onPressed:
                                                                        () {},
                                                                  ),
                                                                ],
                                                              );
                                                            });
                                                      }
                                                    }),
                                              ],
                                            );
                                          });
                                    }
                                  },
                                  //style: TextStyle(color: Colors.white,fontSize: 20,
                                ),
                              )
                              //     new SizedBox(height: 2,),
                              ),
                          Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.only(right: 39),
                                child: new FlatButton(
                                  child: Text(
                                    'E1-Meeting',
                                    style: TextStyle(
                                      fontSize: 12.0, color: Colors.black,

                                      //fontWeight: FontWeight.bold,
                                      //decoration: TextDecoration.none,
                                    ),
                                  ),
                                  onPressed: () async {
                                    if (globals.meetcount == 4) {
                                      bool val = await isConnected();

                                      if (val) {
                                        Dialogs.showLoadingDialog(
                                            context, _keyLoader);
                                        List<String> asss =
                                            await _dates.getDatvals();
                                        asss = await _dates.convertvals(asss);

                                        Navigator.of(_keyLoader.currentContext,
                                                rootNavigator: true)
                                            .pop();

                                        bool valss =
                                            await _checker.checkfees(4);

                                        //    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
                                        if (valss) {
                                          Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                                builder: (context) => new EM1(
                                                    tags: asss,
                                                    eml: globals.email)),
                                          );

                                          //if already booked than popup meeting Already BBooked ,true than go to booking page.
                                        } else {
                                          //   //AlertBox that Admin has not Confirmed the Payment.
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                // return object of type Dialog
                                                return AlertDialog(
                                                  title: new Text(
                                                      " Please Note !!  "),
                                                  content: new Text(
                                                    'Payment has not yet been processed as mentioned in Letter of Engagement previously , To check the Payment Details Please Click Yes !! ',
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        fontFamily: 'Arial'),
                                                  ),
                                                  actions: <Widget>[
                                                    new FlatButton(
                                                      child: new Text("YES"),
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  new Payments()),
                                                        );
                                                      },
                                                    ),
                                                    new FlatButton(
                                                      child: new Text("NO"),
                                                      onPressed: () {
                                                        Navigator.pop(context);
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
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                15))),
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
                                                    onPressed: () {},
                                                  ),
                                                ],
                                              );
                                            });
                                      }
                                    } else {
                                      String texst =
                                          await _dates.getlivetest(4);
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            // return object of type Dialog
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(15))),
                                              title: new Text(" Note "),
                                              content: new Text(
                                                texst,
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontFamily: 'Arial'),
                                              ),
                                              actions: <Widget>[
                                                new FlatButton(
                                                    child: new Text("OKAY"),
                                                    onPressed: () async {
                                                      bool val =
                                                          await isConnected();

                                                      if (val) {
                                                        Dialogs
                                                            .showLoadingDialog(
                                                                context,
                                                                _keyLoader);
                                                        List<String> asss =
                                                            await _dates
                                                                .getDatvals();
                                                        asss = await _dates
                                                            .convertvals(asss);

                                                        Navigator.of(
                                                                _keyLoader
                                                                    .currentContext,
                                                                rootNavigator:
                                                                    true)
                                                            .pop();
                                                        if (globals.meetcount ==
                                                            0) {
                                                          Navigator.push(
                                                            context,
                                                            new MaterialPageRoute(
                                                                builder: (context) => new EM1(
                                                                    tags: asss,
                                                                    eml: globals
                                                                        .email)),
                                                          );
                                                        } else if (globals
                                                                .meetcount ==
                                                            1) {
                                                          bool valss =
                                                              await _checker
                                                                  .checkfees(1);

                                                          //    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
                                                          if (valss) {
                                                            Navigator.push(
                                                              context,
                                                              new MaterialPageRoute(
                                                                  builder: (context) => new EM1(
                                                                      tags:
                                                                          asss,
                                                                      eml: globals
                                                                          .email)),
                                                            );

                                                            //if already booked than popup meeting Already BBooked ,true than go to booking page.
                                                          } else {
                                                            //   //AlertBox that Admin has not Confirmed the Payment.
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  // return object of type Dialog
                                                                  return AlertDialog(
                                                                    title: new Text(
                                                                        " Please Note !!  "),
                                                                    content:
                                                                        new Text(
                                                                      'Payment has not yet been processed as mentioned in Letter of Engagement previously , To check the Payment Details Please Click Yes !! ',
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
                                                                            "YES"),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator
                                                                              .push(
                                                                            context,
                                                                            MaterialPageRoute(builder: (context) => new Payments()),
                                                                          );
                                                                        },
                                                                      ),
                                                                      new FlatButton(
                                                                        child: new Text(
                                                                            "NO"),
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
                                                        } else if (globals
                                                                .meetcount ==
                                                            2) {
                                                          bool valss =
                                                              await _checker
                                                                  .checkfees(2);

                                                          //    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
                                                          if (valss) {
                                                            Navigator.push(
                                                              context,
                                                              new MaterialPageRoute(
                                                                  builder: (context) => new EM1(
                                                                      tags:
                                                                          asss,
                                                                      eml: globals
                                                                          .email)),
                                                            );

                                                            //if already booked than popup meeting Already BBooked ,true than go to booking page.
                                                          } else {
                                                            //   //AlertBox that Admin has not Confirmed the Payment.
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  // return object of type Dialog
                                                                  return AlertDialog(
                                                                    title: new Text(
                                                                        " Please Note !!  "),
                                                                    content:
                                                                        new Text(
                                                                      'Payment has not yet been processed as mentioned in Letter of Engagement previously , To check the Payment Details Please Click Yes !! ',
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
                                                                            "YES"),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator
                                                                              .push(
                                                                            context,
                                                                            MaterialPageRoute(builder: (context) => new Payments()),
                                                                          );
                                                                        },
                                                                      ),
                                                                      new FlatButton(
                                                                        child: new Text(
                                                                            "NO"),
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
                                                        } else if (globals
                                                                .meetcount ==
                                                            3) {
                                                          bool valss =
                                                              await _checker
                                                                  .checkfees(3);

                                                          //    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
                                                          if (valss) {
                                                            Navigator.push(
                                                              context,
                                                              new MaterialPageRoute(
                                                                  builder: (context) => new EM1(
                                                                      tags:
                                                                          asss,
                                                                      eml: globals
                                                                          .email)),
                                                            );

                                                            //if already booked than popup meeting Already BBooked ,true than go to booking page.
                                                          } else {
                                                            //   //AlertBox that Admin has not Confirmed the Payment.
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  // return object of type Dialog
                                                                  return AlertDialog(
                                                                    title: new Text(
                                                                        " Please Note !!  "),
                                                                    content:
                                                                        new Text(
                                                                      'Payment has not yet been processed as mentioned in Letter of Engagement previously , To check the Payment Details Please Click Yes !! ',
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
                                                                            "YES"),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator
                                                                              .push(
                                                                            context,
                                                                            MaterialPageRoute(builder: (context) => new Payments()),
                                                                          );
                                                                        },
                                                                      ),
                                                                      new FlatButton(
                                                                        child: new Text(
                                                                            "NO"),
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
                                                        } else if (globals
                                                                .meetcount ==
                                                            4) {
                                                          bool valss =
                                                              await _checker
                                                                  .checkfees(4);

                                                          //    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
                                                          if (valss) {
                                                            Navigator.push(
                                                              context,
                                                              new MaterialPageRoute(
                                                                  builder: (context) => new EM1(
                                                                      tags:
                                                                          asss,
                                                                      eml: globals
                                                                          .email)),
                                                            );

                                                            //if already booked than popup meeting Already BBooked ,true than go to booking page.
                                                          } else {
                                                            //   //AlertBox that Admin has not Confirmed the Payment.
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  // return object of type Dialog
                                                                  return AlertDialog(
                                                                    title: new Text(
                                                                        " Please Note !!  "),
                                                                    content:
                                                                        new Text(
                                                                      'Payment has not yet been processed as mentioned in Letter of Engagement previously , To check the Payment Details Please Click Yes !! ',
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
                                                                            "YES"),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator
                                                                              .push(
                                                                            context,
                                                                            MaterialPageRoute(builder: (context) => new Payments()),
                                                                          );
                                                                        },
                                                                      ),
                                                                      new FlatButton(
                                                                        child: new Text(
                                                                            "NO"),
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
                                                        } else if (globals
                                                                .meetcount >
                                                            4) {
                                                          int fcount = globals
                                                                  .meetcount -
                                                              4;
                                                          bool valss =
                                                              await _checker
                                                                  .checkfees(
                                                                      fcount);

                                                          //    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
                                                          if (valss) {
                                                            Navigator.push(
                                                              context,
                                                              new MaterialPageRoute(
                                                                  builder: (context) => new EM1(
                                                                      tags:
                                                                          asss,
                                                                      eml: globals
                                                                          .email)),
                                                            );

                                                            //if already booked than popup meeting Already BBooked ,true than go to booking page.
                                                          } else {
                                                            //   //AlertBox that Admin has not Confirmed the Payment.
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  // return object of type Dialog
                                                                  return AlertDialog(
                                                                    title: new Text(
                                                                        " Please Note !!  "),
                                                                    content:
                                                                        new Text(
                                                                      'Payment has not yet been processed as mentioned in Letter of Engagement previously , To check the Payment Details Please Click Yes !! ',
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
                                                                            "YES"),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator
                                                                              .push(
                                                                            context,
                                                                            MaterialPageRoute(builder: (context) => new Payments()),
                                                                          );
                                                                        },
                                                                      ),
                                                                      new FlatButton(
                                                                        child: new Text(
                                                                            "NO"),
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
                                                                    child:
                                                                        new Text(
                                                                            "OK"),
                                                                    onPressed:
                                                                        () {},
                                                                  ),
                                                                ],
                                                              );
                                                            });
                                                      }
                                                    }),
                                              ],
                                            );
                                          });
                                    }
                                  },
                                  //style: TextStyle(color: Colors.white,fontSize: 20,
                                ),
                              )
                              //     new SizedBox(height: 2,),
                              ),
                          Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.only(right: 39),
                                child: new FlatButton(
                                  child: Text(
                                    'Followup-Meeting',
                                    style: TextStyle(
                                      fontSize: 12.0, color: Colors.black,

                                      //fontWeight: FontWeight.bold,
                                      //decoration: TextDecoration.none,
                                    ),
                                  ),
                                  onPressed: () async {
                                    if (globals.meetcount > 4) {
                                      bool val = await isConnected();
                                      int fcount = globals.meetcount - 4;
                                      if (val) {
                                        Dialogs.showLoadingDialog(
                                            context, _keyLoader);
                                        List<String> asss =
                                            await _dates.getDatvals();
                                        asss = await _dates.convertvals(asss);

                                        Navigator.of(_keyLoader.currentContext,
                                                rootNavigator: true)
                                            .pop();

                                        bool valss =
                                            await _checker.checkfees(fcount);

                                        //    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
                                        if (valss) {
                                          Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                                builder: (context) => new EM1(
                                                    tags: asss,
                                                    eml: globals.email)),
                                          );

                                          //if already booked than popup meeting Already BBooked ,true than go to booking page.
                                        } else {
                                          //   //AlertBox that Admin has not Confirmed the Payment.
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                // return object of type Dialog
                                                return AlertDialog(
                                                  title: new Text(
                                                      " Please Note !!  "),
                                                  content: new Text(
                                                    'Payment has not yet been processed as mentioned in Letter of Engagement previously , To check the Payment Details Please Click Yes !! ',
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        fontFamily: 'Arial'),
                                                  ),
                                                  actions: <Widget>[
                                                    new FlatButton(
                                                      child: new Text("YES"),
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  new Payments()),
                                                        );
                                                      },
                                                    ),
                                                    new FlatButton(
                                                      child: new Text("NO"),
                                                      onPressed: () {
                                                        Navigator.pop(context);
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
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                15))),
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
                                                    onPressed: () {},
                                                  ),
                                                ],
                                              );
                                            });
                                      }
                                    } else {
                                      String texst =
                                          await _dates.getlivetest(4);
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            // return object of type Dialog
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(15))),
                                              title: new Text(" Note "),
                                              content: new Text(
                                                texst,
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontFamily: 'Arial'),
                                              ),
                                              actions: <Widget>[
                                                new FlatButton(
                                                    child: new Text("OKAY"),
                                                    onPressed: () async {
                                                      bool val =
                                                          await isConnected();

                                                      if (val) {
                                                        Dialogs
                                                            .showLoadingDialog(
                                                                context,
                                                                _keyLoader);
                                                        List<String> asss =
                                                            await _dates
                                                                .getDatvals();
                                                        asss = await _dates
                                                            .convertvals(asss);

                                                        Navigator.of(
                                                                _keyLoader
                                                                    .currentContext,
                                                                rootNavigator:
                                                                    true)
                                                            .pop();
                                                        if (globals.meetcount ==
                                                            0) {
                                                          Navigator.push(
                                                            context,
                                                            new MaterialPageRoute(
                                                                builder: (context) => new EM1(
                                                                    tags: asss,
                                                                    eml: globals
                                                                        .email)),
                                                          );
                                                        } else if (globals
                                                                .meetcount ==
                                                            1) {
                                                          bool valss =
                                                              await _checker
                                                                  .checkfees(1);

                                                          //    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
                                                          if (valss) {
                                                            Navigator.push(
                                                              context,
                                                              new MaterialPageRoute(
                                                                  builder: (context) => new EM1(
                                                                      tags:
                                                                          asss,
                                                                      eml: globals
                                                                          .email)),
                                                            );

                                                            //if already booked than popup meeting Already BBooked ,true than go to booking page.
                                                          } else {
                                                            //   //AlertBox that Admin has not Confirmed the Payment.
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  // return object of type Dialog
                                                                  return AlertDialog(
                                                                    title: new Text(
                                                                        " Please Note !!  "),
                                                                    content:
                                                                        new Text(
                                                                      'Payment has not yet been processed as mentioned in Letter of Engagement previously , To check the Payment Details Please Click Yes !! ',
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
                                                                            "YES"),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator
                                                                              .push(
                                                                            context,
                                                                            MaterialPageRoute(builder: (context) => new Payments()),
                                                                          );
                                                                        },
                                                                      ),
                                                                      new FlatButton(
                                                                        child: new Text(
                                                                            "NO"),
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
                                                        } else if (globals
                                                                .meetcount ==
                                                            2) {
                                                          bool valss =
                                                              await _checker
                                                                  .checkfees(2);

                                                          //    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
                                                          if (valss) {
                                                            Navigator.push(
                                                              context,
                                                              new MaterialPageRoute(
                                                                  builder: (context) => new EM1(
                                                                      tags:
                                                                          asss,
                                                                      eml: globals
                                                                          .email)),
                                                            );

                                                            //if already booked than popup meeting Already BBooked ,true than go to booking page.
                                                          } else {
                                                            //   //AlertBox that Admin has not Confirmed the Payment.
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  // return object of type Dialog
                                                                  return AlertDialog(
                                                                    title: new Text(
                                                                        " Please Note !!  "),
                                                                    content:
                                                                        new Text(
                                                                      'Payment has not yet been processed as mentioned in Letter of Engagement previously , To check the Payment Details Please Click Yes !! ',
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
                                                                            "YES"),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator
                                                                              .push(
                                                                            context,
                                                                            MaterialPageRoute(builder: (context) => new Payments()),
                                                                          );
                                                                        },
                                                                      ),
                                                                      new FlatButton(
                                                                        child: new Text(
                                                                            "NO"),
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
                                                        } else if (globals
                                                                .meetcount ==
                                                            3) {
                                                          bool valss =
                                                              await _checker
                                                                  .checkfees(3);

                                                          //    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
                                                          if (valss) {
                                                            Navigator.push(
                                                              context,
                                                              new MaterialPageRoute(
                                                                  builder: (context) => new EM1(
                                                                      tags:
                                                                          asss,
                                                                      eml: globals
                                                                          .email)),
                                                            );

                                                            //if already booked than popup meeting Already BBooked ,true than go to booking page.
                                                          } else {
                                                            //   //AlertBox that Admin has not Confirmed the Payment.
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  // return object of type Dialog
                                                                  return AlertDialog(
                                                                    title: new Text(
                                                                        " Please Note !!  "),
                                                                    content:
                                                                        new Text(
                                                                      'Payment has not yet been processed as mentioned in Letter of Engagement previously , To check the Payment Details Please Click Yes !! ',
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
                                                                            "YES"),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator
                                                                              .push(
                                                                            context,
                                                                            MaterialPageRoute(builder: (context) => new Payments()),
                                                                          );
                                                                        },
                                                                      ),
                                                                      new FlatButton(
                                                                        child: new Text(
                                                                            "NO"),
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
                                                        } else if (globals
                                                                .meetcount ==
                                                            4) {
                                                          bool valss =
                                                              await _checker
                                                                  .checkfees(4);

                                                          //    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
                                                          if (valss) {
                                                            Navigator.push(
                                                              context,
                                                              new MaterialPageRoute(
                                                                  builder: (context) => new EM1(
                                                                      tags:
                                                                          asss,
                                                                      eml: globals
                                                                          .email)),
                                                            );

                                                            //if already booked than popup meeting Already BBooked ,true than go to booking page.
                                                          } else {
                                                            //   //AlertBox that Admin has not Confirmed the Payment.
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  // return object of type Dialog
                                                                  return AlertDialog(
                                                                    title: new Text(
                                                                        " Please Note !!  "),
                                                                    content:
                                                                        new Text(
                                                                      'Payment has not yet been processed as mentioned in Letter of Engagement previously , To check the Payment Details Please Click Yes !! ',
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
                                                                            "YES"),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator
                                                                              .push(
                                                                            context,
                                                                            MaterialPageRoute(builder: (context) => new Payments()),
                                                                          );
                                                                        },
                                                                      ),
                                                                      new FlatButton(
                                                                        child: new Text(
                                                                            "NO"),
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
                                                        } else if (globals
                                                                .meetcount >
                                                            4) {
                                                          int fcount = globals
                                                                  .meetcount -
                                                              4;
                                                          bool valss =
                                                              await _checker
                                                                  .checkfees(
                                                                      fcount);

                                                          //    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
                                                          if (valss) {
                                                            Navigator.push(
                                                              context,
                                                              new MaterialPageRoute(
                                                                  builder: (context) => new EM1(
                                                                      tags:
                                                                          asss,
                                                                      eml: globals
                                                                          .email)),
                                                            );

                                                            //if already booked than popup meeting Already BBooked ,true than go to booking page.
                                                          } else {
                                                            //   //AlertBox that Admin has not Confirmed the Payment.
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  // return object of type Dialog
                                                                  return AlertDialog(
                                                                    title: new Text(
                                                                        " Please Note !!  "),
                                                                    content:
                                                                        new Text(
                                                                      'Payment has not yet been processed as mentioned in Letter of Engagement previously , To check the Payment Details Please Click Yes !! ',
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
                                                                            "YES"),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator
                                                                              .push(
                                                                            context,
                                                                            MaterialPageRoute(builder: (context) => new Payments()),
                                                                          );
                                                                        },
                                                                      ),
                                                                      new FlatButton(
                                                                        child: new Text(
                                                                            "NO"),
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
                                                                    child:
                                                                        new Text(
                                                                            "OK"),
                                                                    onPressed:
                                                                        () {},
                                                                  ),
                                                                ],
                                                              );
                                                            });
                                                      }
                                                    }),
                                              ],
                                            );
                                          });
                                    }
                                  },
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),

                  Align(
                    alignment: Alignment.center,
                    child: Container(
                        child: new FlatButton(
                      child: Row(
                        // Replace with a Row for horizontal icon + text
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.laptopCode,
                            color: Colors.black,
                            size: 18,
                          ),
                          SizedBox(
                            width: 37,
                          ),
                          Text(
                            'DEVELOPER CONTACT',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new DevContact()),
                        );
                      },
                    )),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                        child: new FlatButton(
                      child: Row(
                        // Replace with a Row for horizontal icon + text
                        children: <Widget>[
                          Icon(
                            Icons.keyboard_tab,
                            color: Colors.black,
                            size: 18,
                          ),
                          SizedBox(
                            width: 37,
                          ),
                          Text(
                            'LOGOUT',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),

                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              // return object of type Dialog
                              return AlertDialog(
                                title: new Text(" LOGOUT "),
                                content: new Text(
                                  'Press "YES" to Confirm Logout',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(fontFamily: 'Arial'),
                                ),
                                actions: <Widget>[
                                  new FlatButton(
                                    child: new Text("YES"),
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => new MyApp()),
                                      );
                                    },
                                  ),
                                  new FlatButton(
                                    child: new Text("NO"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      //.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            });
                      },
                      //style: TextStyle(color: Colors.white,fontSize: 20,
                    )
                        //     new SizedBox(height: 2,),
                        ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                        child: new FlatButton(
                      child: Row(
                        // Replace with a Row for horizontal icon + text
                        children: <Widget>[
                          Icon(
                            Icons.error_outline,
                            color: Colors.black,
                            size: 18,
                          ),
                          SizedBox(
                            width: 37,
                          ),
                          Text(
                            'REPORT PROBLEM',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),

                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => new ReportProblem()),
                        );
                      },
                      //style: TextStyle(color: Colors.white,fontSize: 20,
                    )
                        //     new SizedBox(height: 2,),
                        ),
                  ),
                ],
                //  new Align(
                //               alignment: Alignment.center,
                //              child:Container(
                //              child:   new FlatButton(
                //                        child: Row( // Replace with a Row for horizontal icon + text
                //       children: <Widget>[
                //         Icon(Icons.home),  SizedBox(width: 32,),

                //                  Text('HOME',
                //               style: TextStyle(fontSize: 12.0,color: Colors.black,
                //               ),),
                //       ],
                //     ),

                //                onPressed: (){},
                //                        //style: TextStyle(color: Colors.white,fontSize: 20,
                //             )
                //                  //     new SizedBox(height: 2,),
                //             ),),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget dashboard(BuildContext context) {
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
                  // Align(alignment:Alignment.center,
                  // new Text(
                  //   "Select Meeting Dat",
                  //   style: TextStyle(
                  //       fontSize: 17,
                  //       color: Colors.black,
                  //       fontStyle: FontStyle.italic),
                  //   textAlign: TextAlign.center,
                  // ),
                  // //  ),//Slect Meeting Date
                  // Icon(Icons.settings, color: Colors.white),

                  SizedBox(
                    height: 2,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: new Text(
                      "Please Select A Desired Date From Below  !!",
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.black87,
                          fontStyle: FontStyle.normal),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Wrap(
                    children: dateWidget.toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Iterable<Widget> get dateWidget sync* {
    List datas =
        tags.toString().replaceAll('[', '').replaceAll(']', '').split(",");

    for (String dt in datas) {
      yield Padding(
          padding: EdgeInsets.all(6.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              InputChip(
                label: Text(dt.trim(),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    )),
                backgroundColor: Colors.yellow,
                onPressed: () async {
                  bool val = await isConnected();

                  if (val) {
                    Dialogs.showLoadingDialog(context, _keyLoader);
                    List<String> slot = await Slots.getslots(dt.toString());
                    Navigator.of(_keyLoader.currentContext, rootNavigator: true)
                        .pop();
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new EMS(
                              tags: datas,
                              slots: slot,
                              selecteddate: dt.toString(),
                              eml: eml)),
                    );
                  } else {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          // return object of type Dialog
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            title: new Text(" OOPS!! "),
                            content: new Text(
                              "It Seems You Don't Have Active Internet Connection,Please turn on Internet To Proceed.",
                              textAlign: TextAlign.start,
                              style: TextStyle(fontFamily: 'Arial'),
                            ),
                            actions: <Widget>[
                              new FlatButton(
                                child: new Text("OK"),
                                onPressed: () {},
                              ),
                            ],
                          );
                        });
                  }
                },
              )
            ],
          ));
    }
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

Future<bool> isConnected() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  }
  return false;
}

// Center(
//     child: new Theme(
//           data: Theme.of(context).copyWith(
//             canvasColor: Colors.blue[100],),
//   child:Container(
//           padding: EdgeInsets.all(10.0),

//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(12.0),
//             border: Border.all(
//                 color: Colors.blue, style: BorderStyle.solid, width: 1.7),
//           ),
//  child:new DropdownButton(

//                   items: months
//                       .map((value) => DropdownMenuItem(
//                             child:new Container(
//                               child: Text(
//                               value,
//                               style: TextStyle(color: Colors.red,fontStyle: FontStyle.italic,fontFamily: '',fontSize: 18),textAlign: TextAlign.center,
//                             ),

//                             ),
//                             value: value,
//                           ))
//                       .toList(),
//                   onChanged: (selectedAccountType) async {
//               Dialogs.showLoadingDialog(context, _keyLoader);
//        List dates = await _mon.convMnthtoint(selectedAccountType.toString());

//   for(int i=0; i<dates.length;i++){
//    date.add(dates[i].toString().split(",")[0].replaceAll('{', '').replaceAll('}', '').trim());
//    slot1.add(dates[i].toString().split(",")[1].replaceAll('{', '').replaceAll('}', '').trim());
//    slot2.add(dates[i].toString().split(",")[2].replaceAll('{', '').replaceAll('}', '').trim());

//   }

//                     setState(() {
//                       selectedType = selectedAccountType;

//                     });
//                     //date,slot1,slot2,months,selectedType
//                   Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();
//                   Navigator.push(
//   context,
//   new MaterialPageRoute(builder: (context) =>new EM2(date:date,slot1:slot1,slot2:slot2,months:months,selectedType:selectedType)),
//     );
//                   },
//                   value: selectedType,
//                   isExpanded: false,
//                   hint: Text(
//                     'Choose Your Preferred Month',
//                     style: TextStyle( color: Colors.lime,fontStyle: FontStyle.italic),
//                   ),
//                 ),
// ),),),
