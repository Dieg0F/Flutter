import 'dart:async';

import 'package:flutter_facebook_login/flutter_facebook_login.dart';

import 'constants.dart';
import 'utils.dart';
import 'request-provider.dart';

const endpoint =
    "me?fields=name,first_name,last_name,email,picture.height(200)&access_token=";

final FacebookLogin facebookLogin = FacebookLogin();
final RequestProvider _requestProvider = RequestProvider();

Future<Object> signInWithFacebook() async {
  Completer completer = Completer();
  var facebookLoginResult =
      await facebookLogin.logInWithReadPermissions(['email']);
  switch (facebookLoginResult.status) {
    case FacebookLoginStatus.error:
      print("FacebookLoginStatus: Error on Login by Facebook");
      return Constants.defaultFacebookError;
      break;
    case FacebookLoginStatus.cancelledByUser:
      print("FacebookLoginStatus: CancelledByUser");
      return Constants.canceledByUser;
      break;
    case FacebookLoginStatus.loggedIn:
      try {
        print("FacebookLoginStatus: LoggedIn");
        Timer timer =
            Utils.requestTimeout(completer, Constants.connectionTimeout);

        var serverResponse = (await _requestProvider
            .get(endpoint + facebookLoginResult.accessToken.token));

        if (serverResponse.hasError) {
          completer.completeError(serverResponse.errorStatus);
        } else {
          timer.cancel();
          completer.complete(serverResponse.response);
        }

        print("serverResponse: $serverResponse");
        return completer.future;
      } catch (error) {
        return Constants.requestFacebookDataError;
      }
      break;
    default:
      return Constants.defaultFacebookError;
  }
}

Future signOutFacebook() async {
  await facebookLogin.logOut();

  print("User Has been Logout");
}
