import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.blue[300], body: CircularProgressIndicator()),
    );
  }
}

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
      content: Row(
    children: <Widget>[
      CircularProgressIndicator(),
      Container(margin: EdgeInsets.only(left: 7), child: Text('Loading...')),
    ],
  ));
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return alert;
      });
}
