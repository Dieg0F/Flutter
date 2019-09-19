import 'connectivity-provider.dart';
import 'constants.dart';
import 'facebook-auth.dart';
import 'facebook-response.dart';

class FacebookRepository {
  Future<FacebookResponse> facebookAuth() async {
    if (await verifyConnection()) {
      var response = await signInWithFacebook();
      print("Response: " + response.toString());

      if (response is String) {
        return FacebookResponse(null, hasError: true, errorMessage: response);
      } else {
        return FacebookResponse(response);
      }
    } else {
      return noInternetConnectionReponse();
    }
  }

  Future userLogout(String userFrom) async {
    if (await verifyConnection()) {
      return await signOutFacebook();
    } else {
      return noInternetConnectionReponse();
    }
  }

  Future<bool> verifyConnection() async {
    return await ConnectivityProvider.hasNetworkConnection();
  }

  FacebookResponse noInternetConnectionReponse() {
    return FacebookResponse(
      null,
      hasError: true,
      errorMessage: Constants.noNetworkConnection,
      errorCode: "",
    );
  }
}
