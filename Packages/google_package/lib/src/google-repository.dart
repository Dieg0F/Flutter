import 'package:firebase_auth/firebase_auth.dart';

import 'connectivity.dart';
import 'constants.dart';
import 'google-login.dart';
import 'google-response.dart';

class GoogleRepository {

  Future<GoogleResponse> googleAuth() async {
    if (await verifyConnection()) {
      var response = await signInWithGoogle();
      print("Response: " + response.toString());

      if (response is FirebaseUser) {
        return GoogleResponse(response);
      } else {
        return GoogleResponse(null, hasError: true, errorMessage: response);
      }
    } else {
      return noInternetConnectionReponse();
    }
  }

  Future userLogout(String userFrom) async {
    if (await verifyConnection()) {
      return await signInWithGoogle();
    } else {
      return noInternetConnectionReponse();
    }
  }

  Future<bool> verifyConnection() async {
    return await ConnectivityProvider.hasNetworkConnection();
  }

  GoogleResponse noInternetConnectionReponse() {
    return GoogleResponse(
      null,
      hasError: true,
      errorMessage: Constants.noNetworkConnection,
      errorCode: "",
    );
  }
}
