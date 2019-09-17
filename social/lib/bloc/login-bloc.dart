import 'package:rxdart/rxdart.dart';
import 'package:social/bloc/login-response.dart';
import 'package:social/repository/login-repository.dart';
import 'package:social/utils/FormValidators/form-validators.dart';

class LoginBloc extends Object with Validators {
  final _emailController = BehaviorSubject<String>();
  final _passController = BehaviorSubject<String>();
  final _loginResponse = BehaviorSubject<LoginResponse>();
  final _loginRepository = LoginRepository();

  Function(String) get emailChanged => _emailController.sink.add;
  Function(String) get passChanged => _passController.sink.add;

  Stream<String> get email => _emailController.stream.transform(emailValidator);
  Stream<String> get pass => _passController.stream.transform(passValidator);
  Stream<bool> get submitCheck =>
      Observable.combineLatest2(email, pass, (e, p) => true);

  Future googleLogin() async {
    _loginResponse.sink.add(await _loginRepository.googleAuth());
  }

  Future facebookLogin() async {
    _loginResponse.sink.add(await _loginRepository.facebookAuth());
  }

  Future formLogin() async {
    var userEmail = _emailController.value;
    var userPass = _passController.value;

    bool hasError = false;

    if (userEmail == "" || userEmail == null) {
      _emailController.sink.addError("Email must not be empty");
      hasError = true;
    }

    if (userPass == "" || userPass == null) {
      _passController.sink.addError("Password must not be empty");
      hasError = true;
    }

    if (hasError == false) {
      _loginResponse.sink
          .add(await _loginRepository.formLogin(userEmail, userPass));
    } else {
      _loginResponse.value = null;
    }
  }

  Future logout(String userFrom) async {
    await _loginRepository.userLogout(userFrom);
    _loginResponse.value = null;
    _emailController.value = null;
    _passController.value = null;
  }

  dispose() {
    _emailController?.close();
    _passController?.close();
    _loginResponse.close();
  }

  BehaviorSubject<LoginResponse> get loginResponse => _loginResponse;
}

final loginBloc = LoginBloc();
