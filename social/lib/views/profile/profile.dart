import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: body(),
      color: Colors.purpleAccent,
    );
  }

  Center body() {
    return Center(
      child: Text(
        "Profile",
        style: Theme.of(context).textTheme.button,
      ),
    );
  }
}
