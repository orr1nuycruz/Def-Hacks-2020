import 'package:flutter/material.dart';
import 'package:linkedin_login/linkedin_login.dart';

class Files extends StatelessWidget {
  static const routeName = "/files";
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Files'),
        ),
        body: Center(
          child: Text("Files"),
        ));
  }
}
