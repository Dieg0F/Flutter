import 'dart:async';

import 'login-constants.dart';

class LoginUtils {
  static Timer requestTimeout(Completer completer, dynamic error) {
    Timer timer;
    timer = Timer(Duration(seconds: LoginConstants.socialLoginTimeout), () {
      completer.completeError(error);
    });
    return timer;
  }
}
