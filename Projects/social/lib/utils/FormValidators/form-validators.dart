import 'dart:async';

mixin Validators {
  var emailValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (email.contains("@")) {
      sink.add(email);
    } else {
      sink.addError("Email is not valid");
    }
  });

  var passValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (pass, sink) {
    if (pass.length > 4) {
      sink.add(pass);
    } else {
      sink.addError("Password length should be greater than 4 chars.");
    }
  });
}
