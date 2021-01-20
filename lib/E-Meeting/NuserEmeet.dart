import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:first_app/Models/rating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';
import 'package:first_app/E-Meeting//DashboardFinal.dart';

final Color backgroundColor = Color(0xFF4A4A58);

class EN1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Meeting',
      home: En1Meet(),
    );
  }
}

class En1Meet extends StatefulWidget {
  @override
  _EM createState() => _EM();
}

class _EM extends State<En1Meet> with SingleTickerProviderStateMixin {
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
          padding: const EdgeInsets.only(top: 0, right: 90.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              //  mainAxisSize: MainAxisSize.min,
              //  mainAxisAlignment: MainAxisAlignment.spaceAround,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CircularProfileAvatar(
                  '', //sets image path, it should be a URL string. default value is empty string, if path is empty it will display only initials
                  radius: 28, // sets radius, default 50.0
                  backgroundColor: Colors
                      .transparent, // sets background color, default Colors.white
                  borderWidth: 10, // sets border, default 0.0
                  initialsText: Text(
                    "MG",
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ), // sets initials text, set your own style, default Text('')
                  borderColor:
                      Colors.blue, // sets border color, default Colors.white
                  elevation:
                      5.0, // sets elevation (shadow of the profile picture), default value is 0.0
                  foregroundColor: Colors.blueAccent.withOpacity(
                      0.5), //sets foreground colour, it works if showInitialTextAbovePicture = true , default Colors.transparent
                  cacheImage:
                      true, // allow widget to cache image against provided url
                  onTap: () {
                    print('adil');
                  }, // sets on tap
                  showInitialTextAbovePicture:
                      true, // setting it true will show initials text above profile picture, default false
                ),

                SizedBox(height: 8),
                Text("Meet Gandhi",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontStyle: FontStyle.italic)),
                SizedBox(height: 8),
                // new SizedBox(height: 100,),

                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                      child: new FlatButton(
                    child: Text(
                      'HOME',
                      style: TextStyle(
                        fontSize: 19.0, color: Colors.white,
                        fontFamily: 'Montserrat',
                        //decoration: TextDecoration.none,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        new MaterialPageRoute(builder: (context) => new DSB()),
                      );
                    },
                    //style: TextStyle(color: Colors.white,fontSize: 20,
                  )
                      //     new SizedBox(height: 2,),
                      ),
                ),
                SizedBox(height: 8),
                new ExpansionTile(
                  // leading: new Icon(
                  //                Icons.arrow_drop_down,color: Colors.red,

                  //              ),

//trailing: new Icon(Icons.arrow_drop_down,color: Colors.blueAccent,) ,
                  title: Text(
                    'EVOKE MEETINGS',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontFamily: 'Montserrat',
                      //  fontStyle: FontStyle.italic,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),

                  children: <Widget>[
                    Align(
                        alignment: Alignment.topLeft,
                        child: new FlatButton(
                          child: Text(
                            'E-Meeting',
                            style: TextStyle(
                              fontSize: 12.0, color: Colors.white,

                              fontWeight: FontWeight.bold,
                              //decoration: TextDecoration.none,
                            ),
                          ),
                          onPressed: () {},
                          //style: TextStyle(color: Colors.white,fontSize: 20,
                        )
                        //     new SizedBox(height: 2,),
                        ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: new FlatButton(
                          child: Text(
                            'V-Meeting',
                            style: TextStyle(
                              fontSize: 12.0, color: Colors.greenAccent,

                              fontWeight: FontWeight.bold,
                              //decoration: TextDecoration.none,
                            ),
                          ),
                          onPressed: () {},
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
    var features = ["AA", "BB", "CC", "DD"];
    var data = [
      [30, 50, 48, 15],
    ];
    String sanitizeDateTime(DateTime dateTime) =>
        "${dateTime.year}-${dateTime.month}-${dateTime.day}";
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
              padding: const EdgeInsets.only(left: 16, right: 16, top: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      InkWell(
                        child: Icon(Icons.menu, color: Colors.white),
                        onTap: () {
                          setState(() {
                            if (isCollapsed)
                              _controller.forward();
                            else
                              _controller.reverse();

                            isCollapsed = !isCollapsed;
                          });
                        },
                      ),
                      Text("My Cards",
                          style: TextStyle(fontSize: 24, color: Colors.white)),
                      Icon(Icons.settings, color: Colors.white),
                    ],
                  ),
                  SizedBox(height: 50),
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
//                             Container(
//                               margin: const EdgeInsets.symmetric(horizontal: 8),
//                               color: Colors.greenAccent,
//                               width: 100,
//                             ),
//                           ],
//                         ),
//                       ),
                  SizedBox(height: 20),

                  new Container(
                      padding: const EdgeInsets.only(
                        left: 90,
                      ),
                      child: new DropdownButton<String>(
                        items: <String>['A', 'B', 'C', 'D'].map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                        onChanged: (_) {},
                      )),

                  new Container(
                      padding: const EdgeInsets.only(
                        left: 90,
                      ),
                      child: new RaisedButton(
                          color: Colors.white,
                          child: new Text(
                            'Rest API',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          onPressed: () async {
                            void printWrapped(String text) {
                              final pattern = RegExp(
                                  '.{500}'); // 800 is the size of each chunk
                              pattern
                                  .allMatches(text)
                                  .forEach((match) => print(match.group(0)));
                            }

//                                                                  Future.delayed(Duration(seconds: 2));
//                                                          right code

//                                                         Response response = await http.get("http://10.0.2.2:8080/vivek/vdapi/getDates");
//                                                            if (response.statusCode == 200) {
//                                                            //printWrapped(response.body.toString());}
// var tagObjsJson = jsonDecode(response.body.toString())['Dates'] as List;
// if(tagObjsJson !=null){
//    List<Tag> tagObjs = tagObjsJson.map((tagJson) => Tag.fromJson(tagJson)).toList();

//  print(tagObjs);}}

                            // If the call to the server was successful, parse the JSON
                            //      var lst = response.body as List;
                            //      lst.map((d) => Album.fromJson(d)).toList();
                            //       print(lst.indexOf(0));
                            //   //Album d =  Album.fromJson(json.decode(response.body)) ;
                            //  // print(d.toString());
                            //   } else {
                            //     // If that call was not successful, throw an error.
                            //       throw Exception('Failed to load post');
                            //   }

                            // print(response.body);

                            // if (response.statusCode == 200) {
                            //   // If the call to the server was successful, parse the JSON
                            //   Map<String,dynamic> values=new Map<String,dynamic>();
                            //   values = json.decode(response.body);
                            //   if(values.length>0){
                            //     print(values.length);
                            //     for(int i=0;i<values.length;i++){
                            //       if(values[i]!=null){
                            //         //Map<String,dynamic> map=values[i];
                            //        //_postList .add(Post.fromJson(map));
                            //       print('Id-------${values['Dates']}');
                            //       }
                            //     }
                            //    }}
                            //                                                    User1 app=User1.fromJson(jsonDecode(response.body));
                            //                                                    //print(json.body);
                          })),

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
}

class Tag {
  String date;
  String slot1;
  String slot2;

  Tag(this.date, this.slot1, this.slot2);

  factory Tag.fromJson(dynamic json) {
    return Tag(json['Date'] as String, json['Slot1'] as String,
        json['Slot2'] as String);
  }

  @override
  String toString() {
    return '{ ${this.date}, ${this.slot1},${this.slot2}}';
  }
}

//                                         new Container(

//                                     padding: const EdgeInsets.only(left: 90,),
//                                      child: new RaisedButton(color: Colors.white,child: new Text('Book Meeting',style: TextStyle(
//                                    color: Colors.black,
//                                                              ),),
//                                                                onPressed: (){
//                                                                  Future<DateTime> selectedDate = showDatePicker(selectableDayPredicate: (DateTime val){
//                                                                       String sanitized = sanitizeDateTime(val);
//           //return !unselectableDates.contains(sanitized);
//                                                                  },

//   context: context,
//   initialDate: DateTime.now(),
//   firstDate: DateTime(2018),
//   lastDate: DateTime(2030),
//   builder: (BuildContext context, Widget child) {
//     return Theme(
//       data: ThemeData.dark(),
//       child: child,
//     );
//   },
// );
// var now = new TimeOfDay.now();
// Future selectedTime = showTimePicker(context: context, initialTime: now,
//   builder: (BuildContext context, Widget child) {
//     return Theme(
//       data: ThemeData.dark(),
//       child: child,
//     );
//   },

// );
//                                                                 // saving(value1.round(),value2.round(),value3.round(),value4.round());
//                                                              // _rate.save(value1.round(),value2.round(),value3.round(),value4.round());
//     //                                                                 Navigator.push(
//     // context,
//     // new MaterialPageRoute(builder: (context) =>new MenuDashboardPage14()),
//     //   );
//                                                               },
//                                                              )  , ),
