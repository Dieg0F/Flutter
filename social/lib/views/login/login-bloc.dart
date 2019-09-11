import 'package:rxdart/subjects.dart';
import 'package:social/firebase/sing-in.dart';

class LoginBloc {
  PublishSubject<String> _subAuth = new PublishSubject<String>();
  PublishSubject<bool> _loading = new PublishSubject<bool>();

  Future googleAuth() async {
    await signInWithGoogle();
  }

  facebookAuth() {}

  PublishSubject<String> get subAuth => _subAuth;

  show() {
    _loading.sink.add(true);
  }

  hide() {
    _loading.sink.add(false);
  }

  PublishSubject<bool> get loading => _loading;
}

final bloc = LoginBloc();
