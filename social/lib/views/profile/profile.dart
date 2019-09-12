import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social/model/user.dart';
import 'package:social/routes/routes.dart';
import 'package:social/views/login/login-bloc.dart';

class ProfilePage extends StatefulWidget {
  User user;
  ProfilePage({Key key, @required this.user}) : super(key: key);

  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.loading.stream,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data) {
            return loadingWidget();
          } else if (bloc.subAuth.value != null) {
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
          CircleAvatar(
            backgroundImage: NetworkImage(widget.user.photoUrl),
            radius: 50,
          ),
          textField(widget.user.name),
          textField(widget.user.email),
          FlatButton(
            child: textField("Logout"),
            onPressed: () {
              print("Logout");
              bloc.show();
              bloc.userLogout(widget.user).whenComplete(() {
                bloc.hide();
                Routes(buildCtx: context).toLogin();
              });
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
