import 'package:first_app/Models/UserData.dart';
import 'package:first_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:email_validator/email_validator.dart';
import 'package:password/password.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registeration',
      home: HomeMaterial(),
    );
  }
}

class HomeMaterial extends StatefulWidget {
  @override
  _HomeMaterialState createState() => _HomeMaterialState();
}

class _HomeMaterialState extends State<HomeMaterial> {
  TextEditingController txtController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _user = User();

  final lps = LoginPageState();
  //(contact: null, fullName: null, paswrd: null, emailAdd: null)
  var passKey = GlobalKey<FormFieldState>();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  ScrollController _scroll;
  FocusNode _focus = new FocusNode();
  List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.indigo,
    Colors.pinkAccent,
    Colors.blue,
  ];
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(" Password Policy "),
          content: new Text(
            "Password must contain at least 8 characters,At least one number & both lower & uppercase letters & at least one special characters.",
            textAlign: TextAlign.start,
            style: TextStyle(fontFamily: 'Arial'),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.white,
        //yellow[50],
        appBar: AppBar(
          flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text('Registration Form',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 18.0,
                  ))),
          backgroundColor: Colors.yellow[200],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: ClampingScrollPhysics(),
          child: Container(
              child: Builder(
                  builder: (context) => Form(
                      key: _formKey,
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            new TextFormField(
                              focusNode: _focus,
                              //padding: new EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                              decoration: InputDecoration(
                                labelText: "Enter Full Name",
                                labelStyle: TextStyle(
                                    fontSize: 16.0, color: Colors.black),
                              ),

                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please Enter Your Full Name';
                                }
                              },
                              keyboardType: TextInputType.text,

                              onSaved: (val) =>
                                  setState(() => _user.fullName = val),
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  labelText: "Enter Email Address",
                                  labelStyle: TextStyle(
                                      fontSize: 15.0, color: Colors.black)),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please Enter Your Email Address';
                                } else if (!EmailValidator.validate(
                                    value.trim())) {
                                  return 'Please Enter Proper Email Address';
                                }
                              },
                              onSaved: (val) => setState(
                                  () => _user.emailAdd = val.toLowerCase()),
                              keyboardType: TextInputType.text,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  labelText: "Enter Contact Number",
                                  labelStyle: TextStyle(
                                      fontSize: 15.0, color: Colors.black)),
                              validator: (value) {
                                String pattterns =
                                    r'(^(?:[+0]9)?[0-9]{10,12}$)';
                                RegExp regExp = new RegExp(pattterns);
                                if (value.isEmpty) {
                                  return 'Please Enter Your Contact Number';
                                } else if (!regExp.hasMatch(value)) {
                                  return 'Please enter valid mobile number';
                                }
                              },
                              onSaved: (val) =>
                                  setState(() => _user.contact = val),
                              keyboardType: TextInputType.text,
                            ),
                            TextFormField(
                              obscureText: true,
                              key: passKey,
                              decoration: InputDecoration(
                                  labelText: "Enter Your Password",
                                  labelStyle: TextStyle(
                                      fontSize: 15.0, color: Colors.black)),
                              validator: (value) {
                                String passPatt =
                                    r'(^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[#$@!%&*?])[A-Za-z\d#$@!%&*?]{8,30}$)';
                                RegExp regExp = new RegExp(passPatt);
                                if (value.isEmpty) {
                                  return 'Please enter password';
                                } else if (!regExp.hasMatch(value)) {
                                  return 'Please Read Password Policy';
                                }
                              },
                              onSaved: (val) =>
                                  setState(() => _user.paswrd = val),
                              keyboardType: TextInputType.text,
                            ),
                            TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                  labelText: "Confirm Your Password",
                                  labelStyle: TextStyle(
                                      fontSize: 15.0, color: Colors.black)),
                              validator: (value1) {
                                var pass = passKey.currentState.value;
                                if (value1.isEmpty) {
                                  return 'Please Enter Your Confirm Password';
                                } else if (pass != value1) {
                                  return "Confirm Password should match password";
                                }
                              },
                              keyboardType: TextInputType.text,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 71.0),
                              child: new RaisedGradientButton(
                                onPressed: () async {
                                  final form = _formKey.currentState;
                                  if (form.validate()) {
                                    form.save();
                                    Dialogs.showLoadingDialog(
                                        context, _keyLoader);
                                    final algorithm = PBKDF2();
                                    String Pass = _user.paswrd;
                                    final hsh = Password.hash(
                                        _user.paswrd.trim(), algorithm);
                                    _user.paswrd = hsh.toString();
                                    // print(_user.paswrd);

                                    var result = await _user.save();
                                    Navigator.pop(
                                      _keyLoader.currentContext,
                                    );
                                    print(result.toString());
                                    if (result.toString().contains("Succ")) {
                                      await showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          // return object of type Dialog
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15))),
                                            title:
                                                new Text(" Congratulations "),
                                            content: new Text(
                                              "Your Registeration is Successful",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontFamily: 'Arial'),
                                            ),
                                            actions: <Widget>[
                                              new FlatButton(
                                                child: new Text("Okay"),
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
                                        },
                                      );
                                    } else if (result
                                        .toString()
                                        .contains("Exists")) {
                                      await showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          // return object of type Dialog
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15))),
                                            title: new Text(" Note "),
                                            content: new Text(
                                              "You Have Already Registered Press Okay to Continue",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontFamily: 'Arial'),
                                            ),
                                            actions: <Widget>[
                                              new FlatButton(
                                                child: new Text("Okay"),
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
                                        },
                                      );
                                    }
                                  }
                                },
                                child: Text(
                                  'SUBMIT',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Montserrat",
                                    fontSize: 16.0,
                                    letterSpacing: 1.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                gradient: LinearGradient(
                                  colors: <Color>[
                                    Colors.yellow[300],
                                    Colors.yellow[400]
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 9.0),
                              child: new FlatButton(
//                          textAlign: TextAlign.start,
                                child: Text(
                                  ' Password Policy ',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.redAccent,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                onPressed: () {
                                  _showDialog();
                                },
                              ),
                            ),
                          ],
                        ),
                      )))),
        ));
  }
}
