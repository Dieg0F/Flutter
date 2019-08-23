import 'package:flutter/material.dart';
import 'package:pfeed/models/profile.dart';
import 'package:pfeed/views/home/home.dart';
import 'package:pfeed/views/profile/profile.dart';

class Routes {
  BuildContext context;

  Routes({@required this.context});

  void toHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Home(),
      ),
    );
  }

  void toProfile(Profile profile) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileDetail(
          profile: profile,
        ),
      ),
    );
  }
}
