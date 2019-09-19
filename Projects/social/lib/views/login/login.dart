import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social/model/user.dart';
import 'package:social/routes/routes.dart';

import 'package:social/bloc/login-bloc.dart';
import 'package:social/views/dialogs/dialogs.dart';

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
          formContent(),
          socialButtons(),
        ],
      ),
      color: Color(0xFF545454),
    );
  }

  Container formContent() {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            formFieldEmail(),
            formFieldPass(),
            formButton(),
          ],
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 40),
      width: MediaQuery.of(context).size.width * 0.75,
    );
  }

  Container formFieldEmail() {
    return Container(
      child: StreamBuilder(
        stream: loginBloc.email,
        builder: (context, snapshot) {
          return TextField(
            onChanged: loginBloc.emailChanged,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              fontSize: 17,
              color: Colors.white54,
            ),
            decoration:
                inputDecoration("Type your email", "Email", snapshot.error),
          );
        },
      ),
      padding: EdgeInsets.only(bottom: 16),
    );
  }

  Container formFieldPass() {
    return Container(
      child: StreamBuilder(
        stream: loginBloc.pass,
        builder: (context, snapshot) {
          return TextField(
            onChanged: loginBloc.passChanged,
            keyboardType: TextInputType.emailAddress,
            obscureText: true,
            style: TextStyle(
              fontSize: 17,
              color: Colors.white54,
            ),
            decoration: inputDecoration(
                "Type you password", "Password", snapshot.error),
          );
        },
      ),
    );
  }

  InputDecoration inputDecoration(
      String hintText, String labelText, String errorMessage) {
    return InputDecoration(
      focusedBorder: inputBoder(Colors.white70),
      enabledBorder: inputBoder(Colors.white30),
      errorBorder: inputBoder(Colors.red.withOpacity(0.38)),
      focusedErrorBorder: inputBoder(Colors.red.withOpacity(0.70)),
      hintText: hintText,
      hintStyle: TextStyle(
        fontSize: 16,
        color: Colors.white54,
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ),
      labelText: labelText,
      labelStyle: TextStyle(
        fontSize: 14,
        color: Colors.white54,
      ),
      errorText: errorMessage,
      errorStyle: TextStyle(
        fontSize: 14,
        color: Colors.red.withOpacity(0.54),
      ),
    );
  }

  OutlineInputBorder inputBoder(Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: color,
        style: BorderStyle.solid,
        width: 1,
      ),
      gapPadding: 5,
      borderRadius: BorderRadius.all(
        Radius.circular(100),
      ),
    );
  }

  Container formButton() {
    return Container(
      child: FutureBuilder(
        builder: (c, snapshot) {
          return InkWell(
            child: buttonContentLogin("LOGIN"),
            onTap: () async {
              dialogs = new Dialogs(ctx: c);
              dialogs.showLoading("Realizando Login");
              await loginBloc.formLogin();
              dialogs.hideLoading();
              if (loginBloc.loginResponse.value != null) {
                if (loginBloc.loginResponse.value.hasError != null) {
                  showSnackBar(loginBloc.loginResponse.value.errorMessage);
                } else {
                  User user = loginBloc.loginResponse.value.data;
                  Routes(buildCtx: context).toProfile(user);
                  showSnackBar("Success!");
                }
              }
            },
          );
        },
      ),
      padding: EdgeInsets.only(top: 8),
    );
  }

  Container socialButtons() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Text(
              "Sign in with",
              style: Theme.of(context).textTheme.button,
            ),
            padding: EdgeInsets.symmetric(vertical: 16),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              googleButton(),
              facebookButton(),
            ],
          )
        ],
      ),
    );
  }

  Container googleButton() {
    return Container(
      child: FutureBuilder(
        builder: (c, snapshot) {
          return InkWell(
              child: buttonContent("Google"),
              onTap: () async {
                dialogs = new Dialogs(ctx: c);
                dialogs.showLoading("Realizando login com Google");
                await loginBloc.googleLogin();
                dialogs.hideLoading();
                if (loginBloc.loginResponse.value.data != null) {
                  Routes(buildCtx: context).toProfile(
                      User.fromFirebase(loginBloc.loginResponse.value.data));
                  showSnackBar("Success!");
                } else {
                  showSnackBar(loginBloc.loginResponse.value.errorMessage);
                }
              });
        },
      ),
      margin: EdgeInsets.symmetric(horizontal: 16),
    );
  }

  Container facebookButton() {
    return Container(
      child: FutureBuilder(
        builder: (c, snap) {
          return InkWell(
            child: buttonContent("Facebook"),
            onTap: () async {
              dialogs = new Dialogs(ctx: c);
              dialogs.showLoading("Realizando login com Facebook");
              await loginBloc.facebookLogin();
              dialogs.hideLoading();
              if (loginBloc.loginResponse.value.data != null) {
                Routes(buildCtx: context).toProfile(
                    User.fromFacebook(loginBloc.loginResponse.value.data));
                showSnackBar("Success!");
              } else {
                showSnackBar(loginBloc.loginResponse.value.errorMessage);
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

  Container buttonContentLogin(String text) {
    return Container(
      child: Center(
        child: buttonText(text),
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.green,
          style: BorderStyle.solid,
          width: 1,
        ),
        borderRadius: new BorderRadius.all(
          Radius.circular(100),
        ),
        color: Colors.green,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      width: MediaQuery.of(context).size.width * 0.75,
    );
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
