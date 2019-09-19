import 'package:connectivity/connectivity.dart';

class ConnectivityProvider {
  static Future<bool> hasNetworkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }
    return true;
  }
}
