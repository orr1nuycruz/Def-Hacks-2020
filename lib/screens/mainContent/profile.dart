import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile>
    with SingleTickerProviderStateMixin {
  String getAuthEmailUser;
  final db = Firestore.instance;
  final prefs = SharedPreferences.getInstance();

  Future<String> getAuthEmailString() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString('AuthEmail');
    return stringValue;
  }

  Future getPost() async {
    QuerySnapshot qn = await db
        .collection("Posts")
        .where("Email", isEqualTo: getAuthEmailUser)
        .getDocuments();
    //QuerySnapshot qn = await db.collection("Users").where("Reason For Joining", isEqualTo: "Career").getDocuments();
    return qn.documents;
  }

  @override
  void initState() {
    this.getAuthEmailString().then((value) => getAuthEmailUser = value);
    //getAuthEmailUser = "orr1n@hotmail.com"
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Container(
          child: Center(
        child: Column(
          children: <Widget>[
            Icon(
              Icons.add_box,
              size: 80,
            ),
            new StreamBuilder(
                stream: db
                    .collection("Users")
                    .document(getAuthEmailUser ?? "")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return new Text("Loading");
                  } else {
                    var userDocument = snapshot.data;
                    return Container(
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            new Text(
                              userDocument["First Name"] +
                                  " " +
                                  userDocument["Last Name"],
                              style: TextStyle(fontSize: 45),
                            ),
                            new Text(
                              userDocument["Job Position"],
                              style:
                                  TextStyle(fontSize: 20, color: Colors.grey),
                            ),
                            new Text(
                              userDocument["Location"],
                              style:
                                  TextStyle(fontSize: 20, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                }),
            SizedBox(height: 70),
            new Expanded(
              child: FutureBuilder(
                future: getPost(),
                builder: (BuildContext _, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return new Text("Loading...");
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext _, int index) {
                          return Card(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  title: Text(
                                    snapshot.data[index].data["Title"],
                                    style: TextStyle(fontSize: 25),
                                  ),
                                ),
                                SizedBox(height: 20),
                                ListTile(
                                  subtitle:
                                      Text(snapshot.data[index].data["Post"]),
                                ),
                              ],
                            ),
                            elevation: 2,
                            color: Colors.white70,
                            shape: new RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          );
                        });
                  }
                },
              ),
            ),
          ],
        ),
      )),
    );
  }
}
