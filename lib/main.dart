import 'package:camera/camera.dart';
import 'package:devhacks/faceCall.dart';
import 'package:devhacks/imageToText.dart';
import 'package:devhacks/screens/login_registration/registration.dart';
import 'package:devhacks/takePictureScreen.dart';
import 'package:flutter/material.dart';
import 'files.dart';
import 'home.dart';
import 'screens/login_registration/login.dart';

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
      routes: {
        Login.routeName: (context) => Login(),
        Registration.routeName: (context) => Registration(),
        Files.routeName: (context) => Files(),
        FaceCall.routeName: (context) => FaceCall(),
        ImageToText.routeName: (context) => ImageToText(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
