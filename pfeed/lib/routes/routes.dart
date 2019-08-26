import 'package:flutter/material.dart';
import 'package:pfeed/models/profile.dart';
import 'package:pfeed/views/details/details.dart';
import 'package:pfeed/views/profiles/profiles.dart';

class Routes {
  BuildContext context;

  Routes({@required this.context});

  void toProfiles() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Profiles(),
      ),
    );
  }

  void toDetails(Profile profile) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Details(
          profile: profile,
        ),
      ),
    );
  }
}
