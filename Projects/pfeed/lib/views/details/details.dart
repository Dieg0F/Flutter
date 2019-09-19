import 'package:flutter/material.dart';
import 'package:pfeed/models/profile.dart';
import 'package:pfeed/views/details/details-widgets.dart';

class Details extends StatefulWidget {
  Profile profile;

  Details({Key key, @required this.profile}) : super(key: key);

  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return DetailsWidget(context).mainContent(widget.profile);
  }
}
