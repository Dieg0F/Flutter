import 'package:rxdart/subjects.dart';

import 'facebook-response.dart';
import 'facebook-repository.dart';

class FacebookBloc {
  final _facebookResponse = BehaviorSubject<FacebookResponse>();
  final _loginRepository = FacebookRepository();

  Future facebookLogin() async {
    _facebookResponse.sink.add(await _loginRepository.facebookAuth());
  }

  Future logout(String userFrom) async {
    await _loginRepository.userLogout(userFrom);
    _facebookResponse.value = null;
  }

  dispose() {
    _facebookResponse.close();
  }

  BehaviorSubject<FacebookResponse> get facebookResponse => _facebookResponse;
}

final facebookBloc = FacebookBloc();
