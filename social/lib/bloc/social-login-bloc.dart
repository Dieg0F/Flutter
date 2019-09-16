import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:social/bloc/social-login-constants.dart';
import 'package:social/bloc/social-login-model.dart';
import 'package:social/utils/FacebookLogin/facebook-login.dart';
import 'package:social/utils/GoogleLogin/google-login.dart';
import 'package:social/model/user.dart';

class SocialLoginBloc {
  Future<LoginResponse> googleAuth() async {
    var response = await signInWithGoogle();
    print("Response: " + response.toString());

    if (response is FirebaseUser) {
      return LoginResponse(response);
    } else {
      return LoginResponse(null, errorMessage: response);
    }
  }

  Future<LoginResponse> facebookAuth() async {
    var response = await signInWithFacebook();
    print("Response: " + response);

    if (response == SocialLoginConstants.canceledByUser ||
        response == SocialLoginConstants.requestFacebookDataError ||
        response == SocialLoginConstants.defaultFacebookError) {
      return LoginResponse(null, errorMessage: response);
    } else {
      return LoginResponse(response);
    }
  }

  Future userLogout(User user) async {
    switch (user.userFrom) {
      case "Facebook":
        return await signOutFacebook();
        break;
      case "Google":
        return await signOutGoogle();
        break;
    }
  }
}

final socialLoginBloc = SocialLoginBloc();
