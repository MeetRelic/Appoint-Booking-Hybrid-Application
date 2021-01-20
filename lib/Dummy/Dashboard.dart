import 'package:flutter/material.dart';

final Color backgroundColor = Color(0xFF4A4A58);

class MenuDashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   
    return MaterialApp(
      title: 'HOME',
      home: MenuDashboardPage1(),
          );
        }
      }

class MenuDashboardPage1 extends StatefulWidget {
   
  @override
  _MenuDashboardPageState createState() => _MenuDashboardPageState();

}

class _MenuDashboardPageState extends State<MenuDashboardPage1> with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  double _value=0.0;
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
          padding: const EdgeInsets.only(left: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Dashboard", style: TextStyle(color: Colors.white, fontSize: 22)),
                SizedBox(height: 10),
               // new SizedBox(height: 100,),
              new ExpansionTile(leading: new Icon(
                               Icons.arrow_drop_down,color: Colors.red,
                           
                             ),
                                 title: Text(
                                  'MEETING  ',textAlign: TextAlign.start,
                                  style: TextStyle(color: Colors.white,
                                          fontFamily: 'Montserrat',
                                          fontStyle: FontStyle.italic,
                                        // fontWeight: FontWeight.bold,
                                        ),
                                         ),
                       
                       
                                children: <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                         child: new FlatButton(
                                  child: Text('Forgot Password',
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
                                    Align( alignment: Alignment.bottomLeft,
                                    child: SingleChildScrollView(
                           scrollDirection: Axis.vertical,
                           physics: ClampingScrollPhysics(),
                                     child: Text("My card", style: TextStyle(fontSize: 22, color: Colors.yellowAccent,fontStyle: FontStyle.italic)),
                                    ),),
                                 
                                      Icon(Icons.settings, color: Colors.white)
                                       
                                        
                                   ],
                                 ),
                                 SizedBox(height: 50),
                                 Container(
                                   height: 200,
                                   child: PageView(
                                     controller: PageController(viewportFraction: 0.8),
                                     scrollDirection: Axis.horizontal,
                                     pageSnapping: true,
                                     children: <Widget>[
                                       
                                       Container(
                                         margin: const EdgeInsets.symmetric(horizontal: 8),
                                         width: 100,
                                         color: Colors.redAccent,
                                      //  child: Image(
                                      //      image: new AssetImage("assets/girl.jpg"),
                                      //   fit: BoxFit.cover,
          
                                      // )
                                       
                                       ),
                                       Container(
                                         margin: const EdgeInsets.symmetric(horizontal: 8),
                                         color: Colors.blueAccent,
                                         width: 100,
                                       ),
                                       Container(
                                         margin: const EdgeInsets.symmetric(horizontal: 8),
                                         color: Colors.greenAccent,
                                         width: 100,
                                       ),
                                     ],
                                   ),
                                 ),


                                 //                         child: PageView(
//                           controller: PageController(viewportFraction: 0.8),
//                          // scrollDirection: Axis.horizontal,
                          
//                           children: <Widget>[
//                          Container(
//                              /// margin: const EdgeInsets.symmetric(horizontal: 1),
// //color: Colors.white,

// height: 20,
//                               width: 30,
//                               padding: const EdgeInsets.only(top:20,left: 80),
                         // alignment: Alignment.center,
                                 SizedBox(height: 20),
                                 Text("How Much Would you rate yourself on fitness?? ${_value.toString().trim().split(".")[0]} %", style: TextStyle(color: Colors.white, fontSize: 15),),
                                new Slider(
                                  value: _value,min: 0,
                                  max: 100,activeColor: Colors.blue,
                                  inactiveColor: Colors.redAccent,onChanged: (value){
                                    _onchanged(value);
                                                                      },
                                                                    ),

                                 // SizedBox(height: 20),
                                 Text("How Much Would you rate yourself on fitness?? ${_value.toString().trim().split(".")[0]} %", style: TextStyle(color: Colors.white, fontSize: 15),),
                                new Slider(
                                  value: _value,min: 0,
                                  max: 100,activeColor: Colors.blue,
                                  inactiveColor: Colors.redAccent,onChanged: (value){
                                    _onchanged(value);
                                                                      },
                                                                    ),
                                                                     SizedBox(height: 20),
                                 Text("How Much Would you rate yourself on fitness?? ${_value.toString().trim().split(".")[0]} %", style: TextStyle(color: Colors.white, fontSize: 15),),
                                new Slider(
                                  value: _value,min: 0,
                                  max: 100,activeColor: Colors.blue,
                                  inactiveColor: Colors.redAccent,onChanged: (value){
                                    _onchanged(value);
                                                                      },
                                                                    )

                                                                   ],
                                                                 ),
                                                               ),
                                                             ),
                                                           ),
                                                         ),
                                                       );
                                                     }
                                                   
                                      void _onchanged( double value) {
                                        setState(() { 
                                         _value =value;
                                        });

                                      }
  
}



     // Text("Dashboard", style: TextStyle(color: Colors.white, fontSize: 22)),
                // SizedBox(height: 10),
                // Text("Messages", style: TextStyle(color: Colors.white, fontSize: 22)),
                // SizedBox(height: 10),
                // Text("Utility Bills", style: TextStyle(color: Colors.white, fontSize: 22)),
                // SizedBox(height: 10),
                // Text("Funds Transfer", style: TextStyle(color: Colors.white, fontSize: 22)),
                // SizedBox(height: 10),
                // Text("Branches", style: TextStyle(color: Colors.white, fontSize: 22)),



                                //ListView.separated(
                                //    shrinkWrap: true,
                                //      itemBuilder: (context, index) {
                                //    return ListTile(
                                //      title: Text("Macbook"),
                                //      subtitle: Text("Apple"),
                                //      trailing: Text("-2900"),
                                //    );
                                //  }, separatorBuilder: (context, index) {
                                //    return Divider(height: 16);
                                //  }, itemCount: 5)