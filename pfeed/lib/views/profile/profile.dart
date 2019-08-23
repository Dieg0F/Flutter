import 'package:flutter/material.dart';
import 'package:pfeed/models/profile.dart';
import 'package:pfeed/views/profile/profile-widgets.dart';

class ProfileDetail extends StatefulWidget {
  Profile profile;

  ProfileDetail({Key key, @required this.profile}) : super(key: key);

  _ProfileDetailState createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {
  @override
  Widget build(BuildContext context) {
    return ProfileWidget(context).mainContent(widget.profile);
  }
}
