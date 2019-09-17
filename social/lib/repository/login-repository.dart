import 'dart:convert';

import 'package:social/data/server/request-provider.dart';
import 'package:social/model/server-response.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:social/bloc/login-constants.dart';
import 'package:social/bloc/login-response.dart';
import 'package:social/model/user.dart';
import 'package:social/utils/Connectivity/connectivity.dart';
import 'package:social/utils/FacebookLogin/facebook-login.dart';
import 'package:social/utils/GoogleLogin/google-login.dart';

class LoginRepository {
  RequestProvider _requestProvider = RequestProvider();

  Future<LoginResponse> googleAuth() async {
    if (await verifyConnection()) {
      var response = await signInWithGoogle();
      print("Response: " + response.toString());

      if (response is FirebaseUser) {
        return LoginResponse(response);
      } else {
        return LoginResponse(null, hasError: true, errorMessage: response);
      }
    } else {
      return noInternetConnectionReponse();
    }
  }

  Future<LoginResponse> facebookAuth() async {
    if (await verifyConnection()) {
      var response = await signInWithFacebook();
      print("Response: " + response);

      if (response == LoginConstants.canceledByUser ||
          response == LoginConstants.requestFacebookDataError ||
          response == LoginConstants.defaultFacebookError) {
        return LoginResponse(null, hasError: true, errorMessage: response);
      } else {
        return LoginResponse(jsonDecode(response));
      }
    } else {
      return noInternetConnectionReponse();
    }
  }

  Future<LoginResponse> formLogin(String userEmail, String userPass) async {
    if (await verifyConnection()) {
      var userToLogin = {"email": userEmail, "password": userPass};

      ServerResponse serverResponse = await _requestProvider.post(
          'app-client/authenticate', json.encode(userToLogin));

      if (serverResponse.hasError == true) {
        return LoginResponse(
          null,
          hasError: true,
          errorMessage: serverResponse.errorStatus,
          errorCode: serverResponse.errorCode.toString(),
        );
      } else {
        var user = {
          "uId": serverResponse.response['data']['token'],
          "name": "Admin Inatel",
          "phoneNumber": "",
          "email": "admin@inatel.br",
          "photoUrl": "https://img.icons8.com/clouds/2x/user.png",
          "userFrom": "Application Server"
        };

        return LoginResponse(
          User.fromJson(user),
        );
      }
    } else {
      return noInternetConnectionReponse();
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

  Future<bool> verifyConnection() async {
    return await ConnectivityProvider.hasNetworkConnection();
  }

  LoginResponse noInternetConnectionReponse() {
    return LoginResponse(
      null,
      hasError: true,
      errorMessage: LoginConstants.noNetworkConnection,
      errorCode: "",
    );
  }
}
