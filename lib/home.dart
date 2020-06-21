import 'package:devhacks/faceCall.dart';
import 'package:devhacks/imageToText.dart';
import 'package:devhacks/screens/login_registration/login.dart';
import 'package:devhacks/screens/login_registration/registration.dart';
import 'package:flutter/material.dart';

import 'files.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Playground"),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () => Navigator.of(context).pushNamed(Files.routeName),
              child: Text("Shared Files"),
            ),
            RaisedButton(
              onPressed: () => Navigator.of(context).pushNamed(Login.routeName),
              child: Text("Login"),
            ),
            RaisedButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(Registration.routeName),
              child: Text("registration"),
            ),
            RaisedButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(FaceCall.routeName),
              child: Text("Face Call"),
            ),
            RaisedButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(ImageToText.routeName),
              child: Text("Image to text (Vision ML + Express API)"),
            ),
          ],
        ),
      ),
    );
  }
}
