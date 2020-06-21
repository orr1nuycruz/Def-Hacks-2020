import 'package:flutter/material.dart';
import 'package:linkedin_login/linkedin_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeFeed extends StatefulWidget {
  @override
  _HomeFeedState createState() => _HomeFeedState();
}

class _HomeFeedState extends State<HomeFeed> {
  String getAuthEmailUser;

  Future<String> getAuthEmailString() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString('AuthEmail');
    return stringValue;
  }

  removeValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Remove String
    prefs.remove("AuthEmail");
  }

  @override
  void initState() {
    getAuthEmailString().then((value) => getAuthEmailUser = value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HOME FEED"),
      ),
      body: Container(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Text(getAuthEmailUser ?? ""),
            LinkedInButtonStandardWidget(
              onTap: () {
                removeValues();
                Navigator.pop(context);
              },
              buttonText: 'Logout',
            ),
          ],
        )),
      ),
    );
  }
}
