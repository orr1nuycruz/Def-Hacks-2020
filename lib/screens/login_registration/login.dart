import 'package:devhacks/model/user.dart';
import 'package:devhacks/screens/login_registration/registration.dart';
import 'package:devhacks/screens/mainContent/home.dart';
import 'package:devhacks/services/Auth.dart';
import 'package:flutter/material.dart';
import 'package:linkedin_login/linkedin_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final String redirectUrl = 'https://medical-collaboration-page.com';
final String clientId = '86jylux9xiur4s';
final String clientSecret = 'oVJw4dLtC140h1Im';

class Login extends StatelessWidget {
  static const routeName = "/login";
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medical Collab App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: LinkedInLogin(),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LinkedInLogin extends StatefulWidget {
  @override
  State createState() => _LinkedInLoginState();
}

class _LinkedInLoginState extends State<LinkedInLogin> {
  UserObject user;
  bool logoutUser = false;
  String getAuthEmailString = "";

  saveAuthCode(String aCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('AuthEmail', aCode);
  }

  Future<String> getAuthCode() async {
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

  void initState() {
    super.initState();
    getAuthCode().then((value) => getAuthEmailString = value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      color: Color(0xff092C66),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Login',
              style: TextStyle(fontSize: 50, color: Colors.white),
            ),
            RaisedButton(
              elevation: 5.0,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => LinkedInUserWidget(
                      appBar: AppBar(
                        title: Text('OAuth User'),
                      ),
                      destroySession: logoutUser,
                      redirectUrl: redirectUrl,
                      clientId: clientId,
                      clientSecret: clientSecret,
                      onGetUserProfile: (LinkedInUserModel linkedInUser) async {
                        print('Access token ${linkedInUser.token.accessToken}');

                        print('User id: ${linkedInUser.userId}');

                        user = UserObject(
                          firstName: linkedInUser.firstName.localized.label,
                          lastName: linkedInUser.lastName.localized.label,
                          email: linkedInUser
                              .email.elements[0].handleDeep.emailAddress,
                        );
                        setState(() {
                          saveAuthCode(linkedInUser
                              .email.elements[0].handleDeep.emailAddress);
                          getAuthCode()
                              .then((value) => getAuthEmailString = value);
                          logoutUser = false;
                        });

                        final status = await Auth().checkUserExists(User.email);
                        if (status == false) {
                          Navigator.pop(context);
                          MaterialPageRoute route = MaterialPageRoute(
                              builder: (context) => ProfileRegistration());
                          Navigator.of(context).push(route);
                        } else {
                          Navigator.pop(context);
                          MaterialPageRoute route = MaterialPageRoute(
                              builder: (context) => HomeFeed());
                          Navigator.of(context).push(route);
                        }
                      },
                      catchError: (LinkedInErrorObject error) {
                        print('Error description: ${error.description},'
                            ' Error code: ${error.statusCode.toString()}');
                        Navigator.pop(context);
                      },
                    ),
                    fullscreenDialog: true,
                  ),
                );
              },
              padding: EdgeInsets.all(15.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Color(0xff007AB6),
              child: Text(
                '  Login With Linkedin ',
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 1.5,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ]),
    );
  }
}

/*
class LinkedInAuthCodeExamplePage extends StatefulWidget {
  @override
  State createState() => _LinkedInAuthCodeExamplePageState();
}

class _LinkedInAuthCodeExamplePageState
    extends State<LinkedInAuthCodeExamplePage> {
  AuthCodeObject authorizationCode;
  bool logoutUser = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        LinkedInButtonStandardWidget(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => LinkedInAuthCodeWidget(
                  destroySession: logoutUser,
                  redirectUrl: redirectUrl,
                  clientId: clientId,
                  onGetAuthCode: (AuthorizationCodeResponse response) {
                    print('Auth code ${response.code}');

                    print('State: ${response.state}');

                    authorizationCode = AuthCodeObject(
                      code: response.code,
                      state: response.state,
                    );
                    setState(() {});

                    Navigator.pop(context);
                  },
                  catchError: (LinkedInErrorObject error) {
                    print('Error description: ${error.description},'
                        ' Error code: ${error.statusCode.toString()}');
                    Navigator.pop(context);
                  },
                ),
                fullscreenDialog: true,
              ),
            );
          },
        ),
        LinkedInButtonStandardWidget(
          onTap: () {
            setState(() {
              authorizationCode = null;
              logoutUser = true;
            });
          },
          buttonText: 'Logout user',
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Auth code: ${authorizationCode?.code} '),
              Text('State: ${authorizationCode?.state} '),
            ],
          ),
        ),
      ],
    );
  }
}
*/
class AuthCodeObject {
  String code, state;

  AuthCodeObject({this.code, this.state});
}

class UserObject {
  String firstName, lastName, email, profilePic;

  UserObject({this.firstName, this.lastName, this.email, profilePic});
}
