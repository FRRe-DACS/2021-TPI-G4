import 'package:flutter/material.dart';

import 'package:sipre/services/services.dart';

import 'package:sipre/views/home_business.dart';

import 'package:sipre/views/menuMinistery.dart';
import 'package:sipre/views/register.dart';

void main() => runApp(Login());

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool itsUser = true;
  final Services s = new Services();
  bool loading = false;
  bool isHide = true;
  String color = '37bbed';
  String colorButton = '1bbb1f';
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController email = new TextEditingController();
  bool error = false;
  TextEditingController password = new TextEditingController();
  int _radioValue = 0;

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          itsUser = true;
          print(itsUser);
          break;
        case 1:
          itsUser = false;
          print(itsUser);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          key: _scaffoldKey,
          resizeToAvoidBottomInset: false,
          backgroundColor: Color(int.parse("0xff$color")),
          body: SafeArea(
              child: Center(
            child: Builder(
              builder: (context) => Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        child: Container(
                          height: 300,
                          width: MediaQuery.of(context).size.width * 0.9,
                          child:
                              Image.asset('assets/images/logo.png', scale: 0.5),
                        ),
                        flex: 2),
                    Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                cursorColor: Colors.white,
                                controller: email,
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return 'Campo obligatorio';
                                  }
                                },
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    labelText: 'Email',
                                    labelStyle: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    )),
                              ),
                              TextFormField(
                                controller: password,
                                obscureText: isHide,
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return 'Campo obligatorio';
                                  }
                                },
                                cursorColor: Colors.white,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    suffixIcon: isHide
                                        ? IconButton(
                                            icon: Icon(Icons.lock_outline,
                                                color: Colors.white),
                                            onPressed: () => isHide = !isHide)
                                        : IconButton(
                                            icon: Icon(Icons.lock_open,
                                                color: Colors.white),
                                            onPressed: () => isHide = !isHide),
                                    labelText: 'Password',
                                    labelStyle: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    )),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  new Radio(
                                    value: 0,
                                    groupValue: _radioValue,
                                    onChanged: _handleRadioValueChange,
                                  ),
                                  new Text(
                                    'Usuario',
                                    style: new TextStyle(
                                        fontSize: 16.0, color: Colors.white),
                                  ),
                                  new Radio(
                                    value: 1,
                                    groupValue: _radioValue,
                                    onChanged: _handleRadioValueChange,
                                  ),
                                  new Text(
                                    'Empresa',
                                    style: new TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 40),
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  color: Colors.white,
                                  child: FlatButton(
                                      color:
                                          Color(int.parse("0xff$colorButton")),
                                      onPressed: () async {
                                        if (_formKey.currentState.validate()) {
                                          setState(() {
                                            loading = true;
                                          });

                                          if (itsUser) {
                                            dynamic res = await s
                                                .signInUserMinistery(
                                                    email.text, password.text)
                                                .catchError((onError) {
                                              setState(() {
                                                loading = false;
                                              });

                                              _scaffoldKey.currentState
                                                  .showSnackBar(new SnackBar(
                                                duration:
                                                    new Duration(seconds: 3),
                                                content: new Row(
                                                  children: <Widget>[
                                                    Icon(Icons.cancel,
                                                        color: Colors.red),
                                                    new Text(onError),
                                                  ],
                                                ),
                                              ));
                                            });
                                            if (res != null) {
                                              setState(() {
                                                loading = false;
                                              });
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          MenuMinistery()));
                                            }
                                          } else {
                                            dynamic res = await s
                                                .signIn(
                                                    email.text, password.text)
                                                .catchError((onError) {
                                              setState(() {
                                                loading = false;
                                              });

                                              _scaffoldKey.currentState
                                                  .showSnackBar(new SnackBar(
                                                duration:
                                                    new Duration(seconds: 3),
                                                content: new Row(
                                                  children: <Widget>[
                                                    Icon(Icons.cancel,
                                                        color: Colors.red),
                                                    new Text(onError),
                                                  ],
                                                ),
                                              ));
                                            });
                                            if (res != null) {
                                              List reportes;

                                              reportes =
                                                  await s.getAllReports();
                                              setState(() {
                                                loading = false;
                                              });

                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          HomeBusiness(
                                                            reports: reportes,
                                                            userBusiness: res,
                                                          )));
                                            } else {
                                              //print('es null');
                                            }
                                          }
                                        } else {
                                          print('invalidos');
                                        }
                                      },
                                      child: Text('Iniciar Sesion',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)))),
                              SizedBox(height: 15),
                              FlatButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Register()));
                                  },
                                  child: Text('Crear Cuenta',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold))),
                              SizedBox(height: 20),
                              loading
                                  ? CircularProgressIndicator()
                                  : Container(),
                            ],
                          ),
                        ),
                        flex: 5),
                  ],
                ),
              ),
            ),
          ))),
    );
  }
}
