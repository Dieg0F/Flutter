import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social/routes/routes.dart';

import 'login-bloc.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: StreamBuilder(
        stream: bloc.loading.stream,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data) {
              return loadingWidget();
            } else {
              return body();
            }
          } else {
            return body();
          }
        },
      ),
    );
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

  Stack loadingWidget() {
    return Stack(
      children: <Widget>[
        body(),
        Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
          color: Colors.black87,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
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
              bloc.hide();
              setState(() {
                if (bloc.subAuth.value != null) {
                  final bar = _snackSample("Success!");
                  _key.currentState.showSnackBar(bar);
                  Routes(buildCtx: context).toProfile(bloc.subAuth.value);
                } else {
                  final bar = _snackSample("Error!");
                  _key.currentState.showSnackBar(bar);
                }
              });
            });
          },
        ),
        FlatButton(
          child: buttonContent("Facebook"),
          onPressed: () {
            print("Facebook");
            bloc.show();
            bloc.facebookAuth().whenComplete(() {
              bloc.hide();
              setState(() {
                if (bloc.subAuth.value != null) {
                  final bar = _snackSample("Success!");
                  _key.currentState.showSnackBar(bar);
                  Routes(buildCtx: context).toProfile(bloc.subAuth.value);
                } else {
                  final bar = _snackSample("Error!");
                  _key.currentState.showSnackBar(bar);
                }
              });
            });
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
