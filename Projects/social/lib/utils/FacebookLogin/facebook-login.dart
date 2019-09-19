import 'dart:async';
import 'dart:convert';

import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'package:social/bloc/login-constants.dart';
import 'package:social/bloc/login-utils.dart';

const graphAPI =
    "https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.height(200)&access_token=";

final FacebookLogin facebookLogin = FacebookLogin();

Future<String> signInWithFacebook() async {
  Completer completer = Completer();
  var facebookLoginResult =
      await facebookLogin.logInWithReadPermissions(['email']);
  switch (facebookLoginResult.status) {
    case FacebookLoginStatus.error:
      print("FacebookLoginStatus: Error on Login by Facebook");
      return LoginConstants.defaultFacebookError;
      break;
    case FacebookLoginStatus.cancelledByUser:
      print("FacebookLoginStatus: CancelledByUser");
      return LoginConstants.canceledByUser;
      break;
    case FacebookLoginStatus.loggedIn:
      try {
        print("FacebookLoginStatus: LoggedIn");
        Timer timer = LoginUtils.requestTimeout(
            completer, LoginConstants.connectionTimeout);
        var graphResponse =
            await http.get('$graphAPI${facebookLoginResult.accessToken.token}');

        timer.cancel();
        completer.complete(jsonDecode(graphResponse.body));

        return completer.future;
      } catch (error) {
        print("Error >> " + error.toString());
        return LoginConstants.requestFacebookDataError;
      }
      break;
    default:
      return LoginConstants.defaultFacebookError;
  }
}

Future signOutFacebook() async {
  await facebookLogin.logOut();

  print("User Has been Logout");
}
