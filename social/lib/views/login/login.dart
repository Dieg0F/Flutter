import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social/bloc/simple-login-bloc.dart';
import 'package:social/model/user.dart';
import 'package:social/routes/routes.dart';

import 'package:social/bloc/loading-bloc.dart';
import 'package:social/bloc/social-login-bloc.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<ScaffoldState> _key = GlobalKey();

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
        stream: simpleLoginBloc.email,
        builder: (context, snapshot) {
          return TextField(
            onChanged: simpleLoginBloc.emailChanged,
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
        stream: simpleLoginBloc.pass,
        builder: (context, snapshot) {
          return TextField(
            onChanged: simpleLoginBloc.passChanged,
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
      child: StreamBuilder<bool>(
        stream: simpleLoginBloc.submitCheck,
        builder: (c, snapshot) {
          return FlatButton(
            child: Text(
              "LOGIN",
              style: Theme.of(context).textTheme.button,
            ),
            color: Color(0xFF4CAF50),
            focusColor: Color(0x334CAF50),
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
            onPressed: () async {
              if (snapshot.hasData) {
                if (snapshot.data) {
                  loadingBloc.show();
                  await simpleLoginBloc.login();
                  setState(() {
                    loadingBloc.hide();
                    if (simpleLoginBloc.userLogged.value != null) {
                      final bar = _snackSample("Success!");
                      _key.currentState.showSnackBar(bar);
                      Routes(buildCtx: context)
                          .toProfile(simpleLoginBloc.userLogged.value);
                    } else {
                      final bar = _snackSample("Error!");
                      _key.currentState.showSnackBar(bar);
                    }
                  });
                }
              } else {
                setState(() {
                  final bar = _snackSample("Verifique os campos!");
                  _key.currentState.showSnackBar(bar);
                });
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
      child: StreamBuilder<User>(
        stream: socialLoginBloc.subAuth.stream,
        builder: (stmContext, snapshot) {
          return FlatButton(
              child: buttonContent("Google"),
              onPressed: () async {
                await socialLoginBloc.googleAuth();
                if (socialLoginBloc.subAuth.value != null) {
                  Routes(buildCtx: context)
                      .toProfile(socialLoginBloc.subAuth.value);
                  showSnackBar("Success!");
                } else {
                  showSnackBar(snapshot.error.toString());
                }
              });
        },
      ),
    );
  }

  Container facebookButton() {
    return Container(
      child: StreamBuilder(
        stream: socialLoginBloc.subAuth.stream,
        builder: (stmContext, snapshot) {
          return FlatButton(
            child: buttonContent("Facebook"),
            onPressed: () async {
              await socialLoginBloc.facebookAuth();
              if (socialLoginBloc.subAuth.value != null) {
                Routes(buildCtx: context)
                    .toProfile(socialLoginBloc.subAuth.value);
                showSnackBar("Success!");
              } else {
                showSnackBar(snapshot.error.toString());
              }
            },
          );
        },
      ),
    );
  }

  void showSnackBar(String message) {
    final bar = _snackSample(message);
    _key.currentState.showSnackBar(bar);
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
