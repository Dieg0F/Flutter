import 'package:facebook_login/model/user.dart';
import 'package:facebook_login/views/login/login.dart';
import 'package:facebook_login/views/profile/profile.dart';
import 'package:flutter/cupertino.dart';

class Routes {
  BuildContext buildCtx;

  Routes({this.buildCtx});

  void toProfile(User userReceived) {
    Navigator.of(buildCtx).pushReplacement(
      CupertinoPageRoute(
        builder: (context) {
          return ProfilePage(user: userReceived);
        },
      ),
    );
  }

  void toLogin() {
    Navigator.of(buildCtx).pushReplacement(
      CupertinoPageRoute(
        builder: (context) {
          return LoginPage();
        },
      ),
    );
  }
}
