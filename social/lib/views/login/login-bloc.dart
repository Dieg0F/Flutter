import 'dart:convert';

import 'package:rxdart/subjects.dart';
import 'package:social/utils/FacebookLogin/facebook-login.dart';
import 'package:social/utils/GoogleLogin/google-login.dart';
import 'package:social/model/user.dart';

class LoginBloc {
  BehaviorSubject<User> _subAuth = new BehaviorSubject<User>();
  PublishSubject<bool> _loading = new PublishSubject<bool>();

  Future googleAuth() async {
    var response = await signInWithGoogle();
    if (response != null) {
      print("Response: " + response.toString());
      _subAuth.sink.add(User.fromFirebase(response));
    } else {
      _subAuth.addError("Error on get user");
    }
  }

  Future facebookAuth() async {
    var response = await signInWithFacebook();

    print("Response: " + response);

    if (response as String == "CancelledByUser") {
      _subAuth.addError("Canceled by User");
    } else if (response as String == "Error on Facebook") {
      _subAuth.addError("Error on Login by Facebook");
    } else if (response as String == "Error on get Facebook Data") {
      _subAuth.addError("Error on get Facebook Data");
    } else {
      _subAuth.sink.add(User.fromFacebook(json.decode(response)));
    }
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

  show() {
    _loading.sink.add(true);
  }

  hide() {
    _loading.sink.add(false);
  }

  PublishSubject<bool> get loading => _loading;
}

final bloc = LoginBloc();
