import 'dart:convert';

import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;

final FacebookLogin facebookLogin = FacebookLogin();

Future<String> signInWithFacebook() async {
  var facebookLoginResult =
      await facebookLogin.logInWithReadPermissions(['email']);
  switch (facebookLoginResult.status) {
    case FacebookLoginStatus.error:
      print("FacebookLoginStatus: Error on Login by Facebook");
      return "Error on Facebook";
      break;
    case FacebookLoginStatus.cancelledByUser:
      print("FacebookLoginStatus: CancelledByUser");
      return "CancelledByUser";
      break;
    case FacebookLoginStatus.loggedIn:
      try {
        print("FacebookLoginStatus: LoggedIn");
        var graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.height(200)&access_token=${facebookLoginResult.accessToken.token}');

        return graphResponse.body;
      } catch (error) {
        return "Error on get Facebook Data";
      }
      break;
  }
}

Future signOutFacebook() async {
  await facebookLogin.logOut();

  print("User Has been Logout");
}
