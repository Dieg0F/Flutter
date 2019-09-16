import 'dart:convert';

import 'package:social/data/server/request-provider.dart';
import 'package:social/model/server-response.dart';
import 'package:social/model/user.dart';

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:social/bloc/login-constants.dart';
import 'package:social/bloc/login-response.dart';
import 'package:social/utils/FacebookLogin/facebook-login.dart';
import 'package:social/utils/GoogleLogin/google-login.dart';
import 'package:social/model/user.dart';

class LoginRepository {
  RequestProvider _requestProvider = RequestProvider();

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

  Future<LoginResponse> formLogin(String userEmail, String userPass) async {
    var userToLogin = {"email": userEmail, "password": userPass};

    ServerResponse serverResponse = await _requestProvider.post(
        'app-client/authenticate', json.encode(userToLogin));

    if (serverResponse.json == null) {
      print("LoginRepository: Error ${serverResponse.errorStatus}");
      print("LoginRepository: Code ${serverResponse.errorCode}");
      return LoginResponse(
        null,
        errorMessage: serverResponse.errorStatus,
        errorCode: serverResponse.errorCode.toString(),
      );
    } else {
      return LoginResponse(
        User(
          name: "Admin",
          email: "admin@inatel.br",
          uId: serverResponse.json['data']['token'],
          phoneNumber: "123456789",
          photoUrl:
              "https://34yigttpdc638c2g11fbif92-wpengine.netdna-ssl.com/wp-content/uploads/2016/09/default-user-img.jpg",
          userFrom: "Application Server",
        ),
      );
    }
  }

  Future userLogout(String userFrom) async {
    switch (userFrom) {
      case "Facebook":
        return await signOutFacebook();
        break;
      case "Google":
        return await signOutGoogle();
        break;
      case "Application Server":
        return null;
    }
  }
}
