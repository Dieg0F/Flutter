
import 'package:rxdart/subjects.dart';

import 'google-repository.dart';
import 'google-response.dart';

class GoogleBloc {
  final _googleResponse = BehaviorSubject<GoogleResponse>();
  final _loginRepository = GoogleRepository();

  Future googleLogin() async {
    _googleResponse.sink.add(await _loginRepository.googleAuth());
  }

  Future logout(String userFrom) async {
    await _loginRepository.userLogout(userFrom);
    _googleResponse.value = null;
  }

  dispose() {
    _googleResponse.close();
  }

  BehaviorSubject<GoogleResponse> get googleResponse => _googleResponse;
}

final googleBloc = GoogleBloc();
