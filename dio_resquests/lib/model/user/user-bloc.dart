import 'package:dio_resquests/model/user/user-repository.dart';
import 'package:dio_resquests/model/user/user-response.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc {
  final UserRepository _repository = UserRepository();
  final BehaviorSubject<UserResponse> _subject =
      BehaviorSubject<UserResponse>();

  getUser() async {
    print("UserBloc: getUser");
    UserResponse response = await _repository.getUser();
    print(response.results[0]);
    _subject.sink.add(response);
  }

  dispose() {
    print("UserBloc: dispose");
    _subject.close();
  }

  BehaviorSubject<UserResponse> get subject => _subject;
}

final bloc = UserBloc();
