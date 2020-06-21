import 'package:flutter/material.dart';

class FaceCall extends StatefulWidget {
  static const routeName = "/faceCall";

  @override
  _FaceCallState createState() => _FaceCallState();
}

class _FaceCallState extends State<FaceCall> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('FaceCall'),
        ),
        body: Center(
          child: Text("FaceCall"),
        ));
  }
}
