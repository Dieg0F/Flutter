import 'dart:convert';

import 'package:rxdart/subjects.dart';
import 'package:social/utils/FacebookLogin/facebook-login.dart';
import 'package:social/utils/GoogleLogin/google-login.dart';
import 'package:social/model/user.dart';

class SocialLoginBloc {
  BehaviorSubject<User> _subAuth = new BehaviorSubject<User>();

  Future googleAuth() async {
    var response = await signInWithGoogle();
    if (response != null) {
      print("Response: " + response.toString());
      _subAuth.sink.add(User.fromFirebase(response));
    } else {
      _subAuth.sink.addError("Error on get user");
    }
  }

  Future facebookAuth() async {
    var response = await signInWithFacebook();

    print("Response: " + response);

    if (response == "CancelledByUser") {
      print("Error");
      _subAuth.addError("Canceled by User");
    } else if (response == "Error on Facebook") {
      _subAuth.addError("Error on Login by Facebook");
    } else if (response == "Error on get Facebook Data") {
      _subAuth.addError("Error on get Facebook Data");
    } else {
      _subAuth.sink.add(User.fromFacebook(json.decode(response)));
    }

    // _subAuth.addError("Errror");
  }

  Future userLogout(User user) async {
    switch (user.userFrom) {
      case "Facebook":
        _subAuth.value = null;
        return await signOutFacebook();
        break;
      case "Google":
        _subAuth.value = null;
        return await signOutGoogle();
        break;
      default:
        _subAuth.value = null;
        return null;
    }
  }

  BehaviorSubject<User> get subAuth => _subAuth;
}

final socialLoginBloc = SocialLoginBloc();
