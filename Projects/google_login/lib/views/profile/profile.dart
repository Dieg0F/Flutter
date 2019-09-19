import 'package:google_login/model/user.dart';
import 'package:google_login/routes/routes.dart';
import 'package:google_package/google_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  User user;
  ProfilePage({Key key, @required this.user}) : super(key: key);

  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(),
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
          Container(
            child: InkWell(
              child: buttonContent("Logout"),
              onTap: () async {
                await googleBloc.logout(widget.user.userFrom);
                Routes(buildCtx: context).toLogin();
              },
              splashColor: Colors.blueGrey,
            ),
            margin: EdgeInsets.symmetric(vertical: 16),
          )
        ],
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
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

  Text textField(String value) {
    return Text(
      value,
      style: Theme.of(context).textTheme.button,
    );
  }
}
