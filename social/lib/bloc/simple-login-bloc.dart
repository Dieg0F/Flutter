import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:social/model/user.dart';
import 'package:social/repository/login-repository.dart';
import 'package:social/utils/FormValidators/form-validators.dart';

class SimpleLoginBloc extends Object with Validators {
  final _emailController = BehaviorSubject<String>();
  final _passController = BehaviorSubject<String>();
  final _userLogged = BehaviorSubject<User>();
  final _loginRepo = LoginRepository();

  Function(String) get emailChanged => _emailController.sink.add;
  Function(String) get passChanged => _passController.sink.add;

  Stream<String> get email => _emailController.stream.transform(emailValidator);
  Stream<String> get pass => _passController.stream.transform(passValidator);

  Stream<bool> get submitCheck =>
      Observable.combineLatest2(email, pass, (e, p) => true);

  BehaviorSubject<User> get userLogged => _userLogged;

  Future login() async {
    print("SimpleLoginBloc: Login");
    var userEmail = _emailController.value;
    var userPass = _passController.value;

    await _loginRepo.login(userEmail, userPass);
  }

  Future logout() async {
    await _loginRepo.logout();
  }

  dispose() {
    _emailController?.close();
    _passController?.close();
  }
}

final simpleLoginBloc = SimpleLoginBloc();
