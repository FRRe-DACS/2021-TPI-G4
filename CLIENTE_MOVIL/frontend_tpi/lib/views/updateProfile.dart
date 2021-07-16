import 'package:flutter/material.dart';
import 'package:sipre/models/userBusiness.dart';
import 'package:sipre/services/services.dart';
import 'package:toast/toast.dart';

void main() => runApp(UpdateProfile());

// ignore: must_be_immutable
class UpdateProfile extends StatefulWidget {
  UserBusiness userBusiness = new UserBusiness();
  UpdateProfile({this.userBusiness});
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  Services s = new Services();
  List<bool> options = [false, false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[300],
          title: Text('Editar Perfil'),
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.pop(context)),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Container(
                color: Colors.grey.withOpacity(0.3),
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'assets/images/logo.png',
                  scale: 0.5,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: ListView(
                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                children: <Widget>[
                  ListTile(
                    title: Text('Empresa'),
                    onTap: () {
                      options[0] = !options[0];
                      showWindow(widget.userBusiness.razon_social);
                    },
                    subtitle: Text(widget.userBusiness.razon_social),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  Divider(
                    endIndent: 10.0,
                    indent: 10.0,
                    color: Colors.black,
                  ),
                  ListTile(
                    title: Text('Telefono'),
                    onTap: () {
                      options[2] = !options[2];
                      showWindow(widget.userBusiness.tel.toString());
                    },
                    subtitle: Text(widget.userBusiness.tel.toString()),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  Divider(
                    endIndent: 10.0,
                    indent: 10.0,
                    color: Colors.black,
                  ),
                  ListTile(
                    title: Text('Correo'),
                    onTap: () {
                      options[3] = !options[3];
                      showWindow(widget.userBusiness.email);
                    },
                    subtitle: Text(widget.userBusiness.email),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  Divider(
                    endIndent: 10.0,
                    indent: 10.0,
                    color: Colors.black,
                  ),
                  ListTile(
                    title: Text('Sector'),
                    onTap: () {
                      options[4] = !options[4];
                      showWindow(widget.userBusiness.industria);
                    },
                    subtitle: Text(widget.userBusiness.industria),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  Divider(
                    endIndent: 10.0,
                    indent: 10.0,
                    color: Colors.black,
                  ),
                  ListTile(
                    title: Text('Ciudad'),
                    onTap: () {
                      options[5] = !options[5];
                      showWindow(widget.userBusiness.ciudad);
                    },
                    subtitle: Text(widget.userBusiness.ciudad),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
            color: Colors.blue[300],
            child: GestureDetector(
              onTap: () {
                s.updateProfileBusiness(widget.userBusiness);
                Toast.show("Empresa actualizada", context,
                    duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
              },
              child: Center(
                  child: Text('Guardar Cambios',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold))),
            ),
            height: MediaQuery.of(context).size.height * 0.08,
            width: MediaQuery.of(context).size.width),
      ),
    );
  }

  void showWindow(String data) async {
    TextEditingController option = new TextEditingController();
    return showDialog(
        context: context,
        builder: (context) => Dialog(
              child: Container(
                  height: 150,
                  width: 200,
                  color: Colors.white24,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('Modificar Campo',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0)),
                      SizedBox(height: 15),
                      Container(
                          margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
                          child: TextField(
                            controller: option,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              hintText: data,
                            ),
                          )),
                      FlatButton(
                          onPressed: () {
                            setState(() {
                              if (options[0]) {
                                widget.userBusiness.razon_social = option.text;
                                options[0] = !options[0];
                              } else {
                                if (options[1]) {
                                  widget.userBusiness.cuit =
                                      int.parse(option.text);
                                  options[1] = !options[1];
                                }
                                if (options[2]) {
                                  widget.userBusiness.tel =
                                      int.parse(option.text);
                                  options[2] = !options[2];
                                }
                                if (options[3]) {
                                  widget.userBusiness.email = option.text;
                                  options[3] = !options[3];
                                }
                                if (options[4]) {
                                  widget.userBusiness.industria = option.text;
                                  options[4] = !options[4];
                                }
                                if (options[5]) {
                                  widget.userBusiness.ciudad = option.text;
                                  options[5] = !options[5];
                                }
                              }
                              Navigator.pop(context);
                            });
                          },
                          child: Text('ACEPTAR',
                              style: TextStyle(color: Colors.blue[300])))
                    ],
                  )),
            ));
  }
}
