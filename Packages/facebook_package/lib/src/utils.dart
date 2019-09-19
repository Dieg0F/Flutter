import 'dart:async';

import 'constants.dart';

class Utils {
  static Timer requestTimeout(Completer completer, dynamic error) {
    Timer timer;
    timer = Timer(Duration(seconds: Constants.socialLoginTimeout), () {
      completer.completeError(error);
    });
    return timer;
  }
}
