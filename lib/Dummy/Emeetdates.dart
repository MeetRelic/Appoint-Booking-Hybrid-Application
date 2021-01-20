
import 'package:first_app/Backups/try.dart';

import 'package:connectivity/connectivity.dart';

import 'package:first_app/Models/DateApi.dart';


import 'package:circular_profile_avatar/circular_profile_avatar.dart';

import 'package:first_app/Models/rating.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';
import 'package:intl/intl.dart';

final Color backgroundColor = Color(0xFF4A4A58);

class EM2 extends StatelessWidget {
  
 final List date;
 final List slot1;
 final List slot2;
 final List <String> months;
 final String selectedType;

EM2({this.date, this.slot2, this.slot1, this.months, this.selectedType});
  @override
  Widget build(BuildContext context) {
 
    return MaterialApp(
      title: 'Meeting',
      home: EM2Meet(date: date,slot1:slot1,slot2:slot2,months:months,selectedType:selectedType),
      
          );
        }
      }

class EM2Meet extends StatefulWidget {
     
 final List date;
 final List slot1;
 final List slot2;
 final List <String> months;
 final String selectedType;
 EM2Meet({this.date, this.slot2, this.slot1, this.months, this.selectedType});
  @override
  _EM2 createState() => _EM2(date: date,slot1:slot1,slot2:slot2,months:months,selectedType:selectedType);

}

class _EM2 extends State<EM2Meet> with SingleTickerProviderStateMixin {
  _EM2({this.date, this.slot2, this.slot1, this.months, this.selectedType});
   List date;
  List slot1;
  List slot2;
  List <String> months;
  var selectedType;
  var selectedmonth;
var index;
final GlobalKey<State> _keyLoader = new GlobalKey<State>();
final _mon=Month('');
final _rate=Rating();
final _datapi =DateApi;
 double value1 = 0.0;
 double value2 = 0.0;
 double value3 = 0.0;
 double value4 = 0.0;
var selectedval;
List<String> datadate=new List<String>();

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
    _menuScaleAnimation = Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0)).animate(_controller);


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
         padding: const EdgeInsets.only(top:0,right: 90.0),
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
          backgroundColor: Colors.transparent, // sets background color, default Colors.white
          borderWidth: 10,  // sets border, default 0.0
          initialsText: Text(
            "MG",
            style: TextStyle(fontSize: 22, color: Colors.white),
          ),  // sets initials text, set your own style, default Text('')
          borderColor: Colors.blue, // sets border color, default Colors.white
          elevation: 5.0, // sets elevation (shadow of the profile picture), default value is 0.0
          foregroundColor: Colors.blueAccent.withOpacity(0.5), //sets foreground colour, it works if showInitialTextAbovePicture = true , default Colors.transparent
          cacheImage: true, // allow widget to cache image against provided url
          onTap: () {
            print('adil');
          }, // sets on tap 
          showInitialTextAbovePicture: true, // setting it true will show initials text above profile picture, default false  
          ),
    
 SizedBox(height: 8),
                Text("Meet Gandh", style: TextStyle(color: Colors.white, fontSize: 22,fontStyle: FontStyle.italic)),
                SizedBox(height: 8),
               // new SizedBox(height: 100,),
               
              Align(
                          alignment: Alignment.topLeft,
                         child:Container(
                           
                         child:   new FlatButton(
                                  child: Text('HOME',
                          style: TextStyle(fontSize: 19.0,color: Colors.white,
                         


                          //decoration: TextDecoration.none,
                          
                          ),), onPressed: (){}, 
                                   //style: TextStyle(color: Colors.white,fontSize: 20,
                        )
                             //     new SizedBox(height: 2,),
                        ),),
                        SizedBox(height: 8),
              new ExpansionTile(
              
                // leading: new Icon(
                //                Icons.arrow_drop_down,color: Colors.red,
                           
                //              ),
                
//trailing: new Icon(Icons.arrow_drop_down,color: Colors.blueAccent,) ,
                                 title: Text(
                                  'EVOKE MEETINGS',textAlign: TextAlign.start,
                                  style: TextStyle(color: Colors.white,
                                  fontSize: 19,
                     
                                        //  fontStyle: FontStyle.italic,
                                        // fontWeight: FontWeight.bold,
                                        ),
                                         ),
                       
                       
                                children: <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                         child: new FlatButton(
                                  child: Text('E-Meeting',
                          style: TextStyle(fontSize: 12.0,color: Colors.white,
                           
                          fontWeight: FontWeight.bold,
                          //decoration: TextDecoration.none,
                          
                          ),), onPressed: (){}, 
                                   //style: TextStyle(color: Colors.white,fontSize: 20,
                        )
                             //     new SizedBox(height: 2,),
                        ),
                         Align(
                          alignment: Alignment.topLeft,
                         child: new FlatButton(
                                  child: Text('V-Meeting',
                          style: TextStyle(fontSize: 12.0,color: Colors.greenAccent,
                           
                          fontWeight: FontWeight.bold,
                          //decoration: TextDecoration.none,
                          
                          ),), onPressed: (){}, 
                                   //style: TextStyle(color: Colors.white,fontSize: 20,
                        )
                             //     new SizedBox(height: 2,),
                        )
                        ],
                            
                            
                            
                             )
                     
                             ],
                           ),
                         ),
                       ),
                     ),
                   );
                 }
               








  Widget  dashboard(BuildContext context) {

datadate=new List<String>();
for(int i=0;i<date.length;i++){

datadate.add(DateFormat("dd-MMM-yyyy").format(DateTime.parse(date[i])));
}
 print(datadate);
    const ticks = [10, 20, 30, 40, 50];
    var features = ["AA", "BB", "CC", "DD"];
    var data = [
      [30, 50, 48, 15],
      
    ];
    //String vals= tags;
     var   currentSelectedValue;
   
  //var months =vals.toString().replaceAll('[','').replaceAll(']', '').trim().split(",");
var newvals=['Please Select Dates FIrst','',''];
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
                         // Align(alignment:Alignment.center,
                         new  Text("Dynamic Booking Form", style: TextStyle(fontSize: 24, color: Colors.yellowAccent,fontStyle: FontStyle.italic),textAlign: TextAlign.center,),
                        //  ),
                         Icon(Icons.settings, color: Color(0xFF4A4A58)),

                        ],
                      ),
               SizedBox(height: 35,), 
                    //   Align(alignment: Alignment.center,
                    // child:new Text(" Book YOUR DATE !! ",
                    //             style: TextStyle(
                    //               color: Colors.black,
                    //               fontWeight: FontWeight.bold,
                    //               fontStyle: FontStyle.italic,
                    //               fontSize: 28.0,
                    //             )),
                    //   ),

Align(alignment: Alignment.center,

child: new  Text("Please Select A Month From DropDown !!", style: TextStyle(fontSize: 17, color: Colors.white,fontStyle: FontStyle.normal),textAlign: TextAlign.center,),
 ), SizedBox(height: 15,),   
       Center(
    child: new Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.blue[100],),
  child:Container(
          padding: EdgeInsets.all(10.0),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
                color: Colors.blue, style: BorderStyle.solid, width: 1.7),
          ),
   child:new DropdownButton(
     
                    items: months
                        .map((value) => DropdownMenuItem(
                              child:new Container(
                                child: Text(
                                value,
                                style: TextStyle(color: Colors.red,fontStyle: FontStyle.italic,fontFamily: '',fontSize: 18),textAlign: TextAlign.center,
                              ),
                              
                              ),
                              value: value,
                            ))
                        .toList(),
                    onChanged: (selection) async {
                Dialogs.showLoadingDialog(context, _keyLoader);              
         List dates = await _mon.convMnthtoint(selection.toString());
    date =new List();
    slot1 =new List();
    slot2=new List();
  
    for(int i=0; i<dates.length;i++){
     date.add(dates[i].toString().split(",")[0].replaceAll('{', '').replaceAll('}', '').trim());
     slot1.add(dates[i].toString().split(",")[1].replaceAll('{', '').replaceAll('}', '').trim());
     slot2.add(dates[i].toString().split(",")[2].replaceAll('{', '').replaceAll('}', '').trim());
       
    }

                      setState(() {
                        selectedmonth = selection;

                      }); 
                      //date,slot1,slot2,months,selectedType
                    Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();
                    Navigator.push(
    context,
    new MaterialPageRoute(builder: (context) =>new EM2(date:date,slot1:slot1,slot2:slot2,months:months,selectedType:selectedType)),
      );
                    },
                    value: selectedmonth,
                    isExpanded: false,
                    hint: Text(
                      selectedType,
                      style: TextStyle( color: Colors.lime,fontStyle: FontStyle.italic),
                    ),
                  ),
          ),),),
 
Align(alignment: Alignment.center,

child: new  Text("Please Select A Date !!", style: TextStyle(fontSize: 17, color: Colors.white,fontStyle: FontStyle.normal),textAlign: TextAlign.center,),
 ), SizedBox(height: 15,),         
Center(
    child: new Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.blue[100],),
  child:Container(
          padding: EdgeInsets.all(10.0),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
                color: Colors.blue, style: BorderStyle.solid, width: 1.7),
          ),
           child:new    DropdownButton(
                    items: datadate.map((value1) => DropdownMenuItem(
                              child: Text(
                                value1,
                                style: TextStyle(color: Color(0xff11b719)),
                              ),
                              value: value1,
                            ))
                        .toList(),
                    onChanged: (vall)  {

                      print('$vall');
                      setState(() {
                        selectedval = vall;
                     
                       
                      });
                      index=datadate.indexOf(vall);
                      //index,datadate,date,slot1,slot2,months,selectedType,selectedval
    //                         Navigator.push(
    // context,
    // new MaterialPageRoute(builder: (context) =>new EM3(date:date,slot1:slot1,slot2:slot2,months:months,selectedType:selectedType,index:index)),
    //   );
                    },
                    value: selectedval,
                    isExpanded: false,
                    hint: Text(
                      'Please Select a Date',
                      style: TextStyle(color: Color(0xff11b719)),
                    ),
                  ),),),),
                                      
                                                            
 ],
                                                                 ),
                                                               ),
                                                             ),
                                                         ),
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
                        SizedBox(height: 10,),
                        Text("Please Wait....",style: TextStyle(color: Colors.blueAccent),)
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


