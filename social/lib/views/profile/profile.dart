import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:social/bloc/loading-bloc.dart';
import 'package:social/bloc/simple-login-bloc.dart';
import 'package:social/bloc/social-login-bloc.dart';

import 'package:social/model/user.dart';

import 'package:social/routes/routes.dart';

class ProfilePage extends StatefulWidget {
  User user;
  ProfilePage({Key key, @required this.user}) : super(key: key);

  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: loadingBloc.loading.stream,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data) {
            return loadingWidget();
          } else if (socialLoginBloc.subAuth.value != null) {
            return body();
          } else {
            return body();
          }
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
          child: Center(
            child: CircularProgressIndicator(),
          ),
          color: Colors.black26,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        )
      ],
    );
  }

  Container body() {
    return Container(
      color: Colors.redAccent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: CircleAvatar(
              backgroundImage: NetworkImage(widget.user.photoUrl),
              radius: 50,
            ),
            padding: EdgeInsets.symmetric(vertical: 8),
          ),
          Container(
            child: textField(widget.user.name),
            padding: EdgeInsets.symmetric(vertical: 8),
          ),
          Container(
            child: textField(widget.user.email),
            padding: EdgeInsets.symmetric(vertical: 8),
          ),
          FlatButton(
            child: textField("Logout"),
            onPressed: () {
              print("Logout");
              loadingBloc.show();
              if (widget.user.userFrom != "Application Server") {
                socialLoginBloc.userLogout(widget.user).whenComplete(() {
                  loadingBloc.hide();
                  Routes(buildCtx: context).toLogin();
                });
              } else {
                simpleLoginBloc.logout().whenComplete(() {
                  loadingBloc.hide();
                  Routes(buildCtx: context).toLogin();
                });
              }
            },
          )
        ],
      ),
    );
  }

  Text textField(String value) {
    return Text(
      value,
      style: Theme.of(context).textTheme.button,
    );
  }
}
