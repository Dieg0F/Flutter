import 'package:flutter/cupertino.dart';
import 'package:social/views/profile/profile.dart';

class Routes {
  BuildContext buildCtx;

  Routes({this.buildCtx});

  void toProfile() {
    Navigator.of(buildCtx).pushReplacement(
      CupertinoPageRoute(
        builder: (context) {
          return ProfilePage();
        },
      ),
    );
  }
}
