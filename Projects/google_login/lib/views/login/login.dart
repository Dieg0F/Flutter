import 'package:google_login/model/user.dart';
import 'package:google_login/routes/routes.dart';
import 'package:google_login/views/dialogs/dialogs.dart';
import 'package:google_package/google_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<ScaffoldState> _key = GlobalKey();
  Dialogs dialogs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(key: _key, body: body());
  }

  Widget _snackSample(String message) => SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.black54,
      );

  Container body() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          facebookButton(),
        ],
      ),
      color: Color(0xFF545454),
      width: MediaQuery.of(context).size.width,
    );
  }

  Container facebookButton() {
    return Container(
      child: FutureBuilder(
        builder: (c, snap) {
          return InkWell(
            child: buttonContent("Google"),
            onTap: () async {
              dialogs = new Dialogs(ctx: c);
              dialogs.showLoading("Realizando login com Google");
              await googleBloc.googleLogin();
              dialogs.hideLoading();
              if (googleBloc.googleResponse.value.data != null) {
                Routes(buildCtx: context).toProfile(User.fromFacebook(
                    googleBloc.googleResponse.value.data));
                showSnackBar("Success!");
              } else {
                showSnackBar(googleBloc.googleResponse.value.errorMessage);
              }
            },
          );
        },
      ),
      margin: EdgeInsets.symmetric(horizontal: 16),
    );
  }

  void showSnackBar(String message) {
    final bar = _snackSample(message);
    _key.currentState.showSnackBar(bar);
  }

  Text buttonText(String text) {
    return Text(
      text,
      style: Theme.of(context).textTheme.button,
    );
  }

  Container buttonContent(String text) {
    return Container(
      child: Text(
        text,
        style: Theme.of(context).textTheme.button,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white30,
          style: BorderStyle.solid,
          width: 1,
        ),
        borderRadius: new BorderRadius.all(
          Radius.circular(100),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
    );
  }
}
