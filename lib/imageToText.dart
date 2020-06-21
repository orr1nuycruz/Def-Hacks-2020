import 'package:flutter/material.dart';

class ImageToText extends StatefulWidget {
  static const routeName = "/imageToText";

  @override
  _ImageToTextState createState() => _ImageToTextState();
}

class _ImageToTextState extends State<ImageToText> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Image to text'),
        ),
        body: Center(
          child: Text("Image to text"),
        ));
  }
}
