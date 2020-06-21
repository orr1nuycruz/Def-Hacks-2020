import 'package:devhacks/data/data.dart';
import 'package:devhacks/model/user.dart';
import 'package:flutter/material.dart';
import 'package:linkedin_login/linkedin_login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileRegistration extends StatefulWidget {
  @override
  _ProfileRegistrationState createState() => _ProfileRegistrationState();
}

class _ProfileRegistrationState extends State<ProfileRegistration> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String getAuthEmailUser;
  TextEditingController getProfileName;
  TextEditingController getFirstName;
  TextEditingController getLastName;
  TextEditingController getLocation;

  final databaseReference = Firestore.instance;

  Future<String> getAuthEmailString() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString('AuthEmail');
    return stringValue;
  }

  void createUser() async {
    databaseReference.collection("Users").document(User.email).setData(
        {
          "LinkedIn Email": User.email, 
          "Profile Name": User.profileName,
          "First Name" : User.firsName,
          "Last Name" : User.lastName,
          "Job Position": User.jobName,
          "Location": User.location});
  }

  @override
  void initState() {
    getAuthEmailString().then((value) => getAuthEmailUser = value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    User.email = getAuthEmailUser;
    return Scaffold(
      appBar: new AppBar(title: Text('Profile Registration')),
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Text(getAuthEmailUser ?? ""),
              SizedBox(
                height: 40,
              ),
              Flexible(
                child: TextFormField(
                  controller: getProfileName,
                  decoration: InputDecoration(
                    hintText: "Profile Name",
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Cannot be empty";
                    } else {
                      setState(() {
                        User.profileName = value;
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
                  controller: getFirstName,
                  decoration: InputDecoration(
                    hintText: "First Name",
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Cannot be empty";
                    } else {
                      setState(() {
                        User.firsName = value;
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
                  controller: getLastName,
                  decoration: InputDecoration(
                    hintText: "Last Name",
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Cannot be empty";
                    } else {
                      setState(() {
                        User.lastName = value;
                      });
                      return null;
                    }
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                color: AppBarTheme.of(context).color,
                child: DropdownButton(
                  items: Data.jobPos(),
                  onChanged: (value) {
                    if (value != "") {
                      setState(() {
                        User.jobName= value;
                        
                      });
                    } else {
                      return null;
                    }
                  },
                  isExpanded: true,
                  hint: Text(
                    User.jobName != null
                        ? "\t\t" + User.jobName
                        : "\t\tSelect a reason for Joining",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Flexible(
                child: TextFormField(
                  controller: getLocation,
                  decoration: InputDecoration(
                    hintText: "City",
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Cannot be empty";
                    } else {
                      setState(() {
                        User.location = value;
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
                    Navigator.pop(context);
                    createUser();
                  } else {
                    print("NOT VALID");
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
