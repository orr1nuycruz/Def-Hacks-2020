import 'package:flutter/material.dart';
import 'package:linkedin_login/linkedin_login.dart';

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
                      onGetUserProfile: (LinkedInUserModel linkedInUser) {
                        print('Access token ${linkedInUser.token.accessToken}');

                        print('User id: ${linkedInUser.userId}');

                        user = UserObject(
                          firstName: linkedInUser.firstName.localized.label,
                          lastName: linkedInUser.lastName.localized.label,
                          email: linkedInUser
                              .email.elements[0].handleDeep.emailAddress,
                        );
                        setState(() {
                          logoutUser = false;
                        });

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
/*            LinkedInButtonStandardWidget(
              iconHeight: 50,
              iconWeight: 40,
              textPadding: EdgeInsets.all(5.0),
              buttonColor: Colors.black,
              onTap: () {
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
                      onGetUserProfile: (LinkedInUserModel linkedInUser) {
                        print('Access token ${linkedInUser.token.accessToken}');

                        print('User id: ${linkedInUser.userId}');

                        user = UserObject(
                          firstName: linkedInUser.firstName.localized.label,
                          lastName: linkedInUser.lastName.localized.label,
                          email: linkedInUser
                              .email.elements[0].handleDeep.emailAddress,
                        );
                        setState(() {
                          logoutUser = false;
                        });

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
              buttonText: 'Login with Linkedin  ',
            ),
              LinkedInButtonStandardWidget(
                onTap: () {
                  setState(() {
                    user = null;
                    logoutUser = true;
                  });
                },
                buttonText: 'Logout',
              ),
              Container(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('First: ${user?.firstName} '),
                    Text('Last: ${user?.lastName} '),
                    Text('Email: ${user?.email}'),
                  ],
                ),
              ),
*/
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
  String firstName, lastName, email;

  UserObject({this.firstName, this.lastName, this.email});
}
