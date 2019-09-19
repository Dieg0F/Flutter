import 'package:flutter/cupertino.dart';
import 'package:social/model/user.dart';
import 'package:social/views/login/login.dart';
import 'package:social/views/profile/profile.dart';

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
