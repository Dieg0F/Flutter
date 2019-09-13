import 'dart:convert';
import 'dart:io';

import 'package:social/bloc/simple-login-bloc.dart';
import 'package:social/data/server/request-provider.dart';
import 'package:social/model/server-response.dart';
import 'package:social/model/user.dart';

class LoginRepository {
  RequestProvider _requestProvider = RequestProvider();

  Future login(String userEmail, String userPass) async {
    var userToLogin = {"email": userEmail, "password": userPass};

    print(json.encode(userToLogin));

    ServerResponse serverResponse = await _requestProvider.post(
        'app-client/authenticate', json.encode(userToLogin));

    if (serverResponse.json == null) {
      print("LoginRepository: Error ${serverResponse.errorStatus}");
      print("LoginRepository: Code ${serverResponse.errorCode}");
      simpleLoginBloc.userLogged.addError(serverResponse.errorStatus);
    } else {
      simpleLoginBloc.userLogged.sink.add(
        User(
          name: "Admin",
          email: "admin@inatel.br",
          uId: serverResponse.json['data']['token'],
          phoneNumber: "123456789",
          photoUrl:
              "https://34yigttpdc638c2g11fbif92-wpengine.netdna-ssl.com/wp-content/uploads/2016/09/default-user-img.jpg",
          userFrom: "Application Server",
        ),
      );
    }
  }

  Future logout() async {
    simpleLoginBloc.userLogged.value = null;
    sleep(Duration(seconds: 2));
  }
}
