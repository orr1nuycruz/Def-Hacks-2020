import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devhacks/screens/mainContent/profile.dart';
import 'package:flutter/material.dart';
import 'package:linkedin_login/linkedin_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeFeed extends StatefulWidget {
  @override
  _HomeFeedState createState() => _HomeFeedState();
}

class _HomeFeedState extends State<HomeFeed> {
  final _formKey = GlobalKey<FormState>();
  final databaseReference = Firestore.instance;
  String getAuthEmailUser;

  TextEditingController title;
  TextEditingController post;
  String getTitle;
  String getPost;

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

  addPost(String str1, String str2) {
    databaseReference
        .collection("Posts")
        .add({"Email": getAuthEmailUser, "Title": getTitle, "Post": getPost});
  }

  createPosts(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: new StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return Container(
                constraints: BoxConstraints.expand(height: 400, width: 200),
                child: Form(
                  key: _formKey,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Flexible(
                          child: TextFormField(
                            controller: title,
                            decoration: InputDecoration(
                              hintText: "Enter Title",
                            ),
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "Cannot be empty";
                              } else {
                                setState(() {
                                  getTitle = value;
                                });
                                return null;
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Flexible(
                          child: TextFormField(
                            controller: post,
                            decoration: InputDecoration(
                              hintText: "Post Your Research",
                            ),
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "Cannot be empty";
                              } else {
                                setState(() {
                                  getPost = value;
                                });
                                return null;
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        RaisedButton(
                          child: Text(
                            "Submit",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            if (this._formKey.currentState.validate()) {
                              addPost(getTitle, getPost);
                              Navigator.of(context).pop();
                              _formKey.currentState.reset();
                            } else {
                              print("ERROR.");
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          );
        });
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
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_box),
            onPressed: () {
              createPosts(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              MaterialPageRoute route =
                  MaterialPageRoute(builder: (context) => UserProfile());
              Navigator.of(context).push(route);
            },
          ),
        ],
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
