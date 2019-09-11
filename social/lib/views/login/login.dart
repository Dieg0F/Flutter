import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social/routes/routes.dart';

import 'login-bloc.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.loading,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data) {
            return loadingWidget();
          } else {}
        } else {
          return body();
        }
      },
    );
  }

  Stack loadingWidget() {
    return Stack(
      children: <Widget>[
        body(),
        Container(
          child: CircularProgressIndicator(),
          color: Colors.black26,
        )
      ],
    );
  }

  Container body() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buttonRow(),
        ],
      ),
      color: Colors.blue,
    );
  }

  Row buttonRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FlatButton(
          child: buttonContent("Google"),
          onPressed: () {
            print("Google");
            bloc.show();
            bloc.googleAuth().whenComplete(() {
              Routes(buildCtx: context).toProfile();
              bloc.hide();
            });
          },
        ),
        FlatButton(
          child: buttonContent("Facebook"),
          onPressed: () {
            print("Facebook");
          },
        )
      ],
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
          width: 2,
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
