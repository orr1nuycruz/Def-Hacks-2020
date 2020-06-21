import 'package:flutter/material.dart';
import 'package:linkedin_login/linkedin_login.dart';

final String redirectUrl = 'https://www.linkedin.com/company/medicdb/';
final String clientId = '773kjsuiahkm51';
final String clientSecret = 'cLLALR35guknlhPP';

class UserObject {
  String firstName, lastName, email;
  UserObject({this.firstName, this.lastName, this.email});
}

class AuthCodeObject {
  String code, state;
  AuthCodeObject({this.code, this.state});
}

class Login extends StatefulWidget {
  State createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    UserObject user;
    AuthCodeObject authorizationCode;

    bool logoutUser = false;

    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Text('Login With LinkedIn'),
              LinkedInButtonStandardWidget(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => LinkedInUserWidget(
                        appBar: AppBar(
                          title: Text('LinkedIn Sign-In'),
                        ),
                        destroySession: logoutUser,
                        redirectUrl: redirectUrl,
                        clientId: clientId,
                        clientSecret: clientSecret,
                        onGetUserProfile: (LinkedInUserModel linkedInUser) {
                          print(
                              'Access token ${linkedInUser.token.accessToken}');

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
            ],
          ),
        ),
      ),
    );
  }
}
