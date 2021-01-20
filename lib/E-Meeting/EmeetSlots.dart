import 'dart:async';
import 'dart:core';
import 'package:first_app/Models/Mandat.dart';
import 'package:first_app/Screens/DevContact.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:connectivity/connectivity.dart';
import 'package:first_app/E-Meeting/payment.dart';
import 'package:first_app/Globalz.dart' as globals;
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:first_app/Models/DynamDates.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:demoji/demoji.dart';
import 'package:first_app/Models/DynamChecker.dart';
import 'package:first_app/Models/GetMinute.dart';
import 'package:first_app/Models/getgoals.dart';
import 'package:first_app/Screens/Reportproblem.dart';
import 'package:first_app/main.dart';
import 'package:first_app/Models/Bookdates.dart';
import 'package:first_app/Screens/customdates.dart';
import 'package:first_app/E-Meeting/EMeet.dart';
import 'package:first_app/E-Meeting//DashboardFinal.dart';

final Color backgroundColor = Colors.white;

class EMS extends StatelessWidget {
  final List tags;
  final List slots;
  final String selecteddate;
  final String eml;
  EMS({this.tags, this.slots, this.selecteddate, this.eml});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meeting',
      home: EMSMeet(
          tags: tags, slots: slots, selecteddate: selecteddate, eml: this.eml),
    );
  }
}

class EMSMeet extends StatefulWidget {
  final String eml;
  final List tags;
  final List slots;
  final _mandat = Mandat();
  final String selecteddate;
  EMSMeet({this.tags, this.slots, this.selecteddate, this.eml});
  @override
  _EMS createState() =>
      _EMS(tags: tags, slots: slots, selecteddate: selecteddate, eml: this.eml);
}

class _EMS extends State<EMSMeet> with SingleTickerProviderStateMixin {
  _EMS({this.tags, this.slots, this.selecteddate, this.eml});
  String eml;
  String selecteddate;
  final _checker = DynamChecker();
  final _getmin = GetMinute();
  final _getgaal = Getgoals();
  final _dates = DynamDates('');
  String type = '';
  List tags;
  List slots;
  final bookng = Bookdates();
  String selectedslots;
  bool _isclicked = false;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final GlobalKey<State> _keyLoader1 = new GlobalKey<State>();
  var selectedCurrency, selectedType;

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
    //`E-Meeting`, `V-Meeting`, `O-Meeting`, `K-Meeting`, `E1-Meeting`, `Follow_up_meeting
    if (globals.meetcount == 0) {
      type = "E-Meeting";
    } else if (globals.meetcount == 1) {
      type = "V-Meeting";
    } else if (globals.meetcount == 2) {
      type = "O-Meeting";
    } else if (globals.meetcount == 3) {
      type = "K-Meeting";
    } else if (globals.meetcount == 4) {
      type = "E1-Meeting";
    } else if (globals.meetcount == 5) {
      type = "F-Meeting";
    } else if (globals.meetcount > 5) {
      int fcount = globals.meetcount - 5;
      type = "Follow_up_meeting" + fcount.toString() + "meet";
    }
    // Set<String> unselectedates;
    // unselectedates.add();
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
                  SizedBox(
                    height: 2,
                  ),
                  //   Align(alignment: Alignment.center,
                  // child:new Text(" Book YOUR DATE !! ",
                  //             style: TextStyle(
                  //               color: Colors.black,
                  //               fontWeight: FontWeight.bold,
                  //               fontStyle: FontStyle.italic,
                  //               fontSize: 28.0,
                  //             )),
                  //   ),

                  Align(
                    alignment: Alignment.center,
                    child: new Text(
                      "Please Select A Desired Date From Below  !!",
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontStyle: FontStyle.normal),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),

                  Wrap(
                    children: ddateWidget.toList(),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: new Text(
                      "Please Select A Slot For Selected Date:" +
                          "(" +
                          selecteddate.trim() +
                          ")" +
                          " !!",
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontStyle: FontStyle.normal),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Wrap(
                    children: slotwidget.toList(),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: textt,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: getButton,
                  ),

                  SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'No Convenient Dates ?  ',
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontStyle: FontStyle.normal),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      new FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9)),
                          color: Colors.black87,
                          onPressed: () {
                            Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new CDAT()),
                            );
                          },
                          child: Text(
                            'CLICK HERE  ',
                            style: TextStyle(
                              color: Colors.yellow,
                              // fontFamily: "Montserrat",
                              fontSize: 11.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Iterable<Widget> get ddateWidget sync* {
    List datas =
        tags.toString().replaceAll('[', '').replaceAll(']', '').split(",");
    bool chck = true;
    for (String dt in datas) {
      if (dt.toString().contains(selecteddate)) {
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
                          color: Colors.yellow,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        )),
                    showCheckmark: chck,
                    checkmarkColor: Colors.yellow,
                    selected: chck,
                    selectedColor: Colors.black,
                    onPressed: () async {
                      bool val = await isConnected();

                      if (val) {
                        Dialogs.showLoadingDialog(context, _keyLoader);
                        List<String> slot = await Slots.getslots(dt.toString());
                        Navigator.of(_keyLoader.currentContext,
                                rootNavigator: true)
                            .pop();
                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new EMS(
                                  tags: datas,
                                  slots: slot,
                                  selecteddate: dt.toString())),
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
                ]));
      } else {
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
                            fontSize: 10)),
                    backgroundColor: Colors.yellow,
                    onPressed: () async {
                      bool val = await isConnected();

                      if (val) {
                        Dialogs.showLoadingDialog(context, _keyLoader);
                        List<String> slot = await Slots.getslots(dt.toString());
                        Navigator.of(_keyLoader.currentContext,
                                rootNavigator: true)
                            .pop();
                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new EMS(
                                  tags: datas,
                                  slots: slot,
                                  selecteddate: dt.toString())),
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
                ]));
      }
    }
  }

  Widget get textt {
    if (_isclicked) {
      SizedBox(height: 8);
      return new Text(
        "Book Your Meeting For Selected Date And Time ...!",
        style: TextStyle(
            fontSize: 12, color: Colors.black, fontStyle: FontStyle.normal),
        textAlign: TextAlign.center,
      );
    }
  }

  Widget get getButton {
    final _mandat = Mandat();
    if (_isclicked) {
      return new FlatButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Colors.black87,
          child: Text(
            "CONFIRM BOOKING",
            style: TextStyle(
              color: Colors.yellow,
              // fontFamily: "Montserrat",
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () async {
            bool val = await isConnected();
            if (val) {
              Dialogs.showLoadingDialog(context, _keyLoader);
              var confirm = await bookng.bookingdates(
                  selecteddate.trim(), type, eml, selectedslots);
              Navigator.pop(
                _keyLoader.currentContext,
              );
              if (!confirm.toString().contains('pend')) {
                Dialogs2.showLoadingDialog(context, _keyLoader1);
                var a = await _mandat.getmandat();
                Navigator.pop(
                  _keyLoader1.currentContext,
                );
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      // return object of type Dialog
                      return AlertDialog(
                        title: new Text(" SUCCESS !! "),
                        content: new Text(
                          'Meeting Booked Successfully !! ',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontFamily: 'Arial'),
                        ),
                        actions: <Widget>[
                          new FlatButton(
                            child: new Text("Okay"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    });
                Navigator.pushReplacement(
                  context,
                  new MaterialPageRoute(builder: (context) => new DSB()),
                );
              } else if (confirm.toString().contains('pend')) {
                print(globals.meetcount);
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      // return object of type Dialog
                      return AlertDialog(
                        title: new Text(" Payment Pending !!  "),
                        content: new Text(
                          'Payment Pending,please process as described earlier !! ',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontFamily: 'Arial'),
                        ),
                        actions: <Widget>[
                          new FlatButton(
                            child: new Text("Okay"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    });
              } else {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      // return object of type Dialog
                      return AlertDialog(
                        title: new Text(" ERROR !!  "),
                        content: new Text(
                          'Report Issue and we will assist. ',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontFamily: 'Arial'),
                        ),
                        actions: <Widget>[
                          new FlatButton(
                            child: new Text("Okay"),
                            onPressed: () {
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => new ReportProblem()),
                              );
                            },
                          ),
                          new FlatButton(
                            child: new Text("Cancel"),
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
                          borderRadius: BorderRadius.all(Radius.circular(15))),
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
          });
    }
  }

  Iterable<Widget> get slotwidget sync* {
    List datas =
        slots.toString().replaceAll('[', '').replaceAll(']', '').split(",");

    for (String dt in datas) {
      if (selectedslots.toString().contains(dt.toString().trim())) {
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
                        color: Colors.yellow,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      )),
                  backgroundColor: Colors.black,
                  checkmarkColor: Colors.yellow,
                  showCheckmark: true,
                  selected: true,
                  selectedColor: Colors.black,
                  onSelected: (bool select) async {
                    setState(() {
                      selectedslots = "";

                      _isclicked = false;
                    });
                    print(_isclicked);
                  })
            ],
          ),
        );
      } else {
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
                    onSelected: (bool select) async {
                      setState(() {
                        selectedslots = dt.toString().trim();

                        _isclicked = true;
                      });
                    })
              ]),
        );
      }
    }
  }
}

class Dialogs2 {
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
                          "Confirming Meeting....",
                          style: TextStyle(color: Colors.blueAccent),
                        )
                      ]),
                    )
                  ]));
        });
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
    this.width = 100.0,
    this.height = 100.0,
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
