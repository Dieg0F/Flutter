import 'package:flutter/material.dart';
import 'package:pfeed/models/profile.dart';
import 'package:pfeed/views/home/home-widgets.dart';
import 'package:pfeed/views/widgets/widgets.dart';

import 'home-bloc.dart';

class Home extends StatefulWidget {
  List<ProfileResponse> profiles = new List<ProfileResponse>();

  Home() {
    profiles = [];
  }

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _HomeState() {
    homeBloc.getProfiles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("Perfis"),
      body: StreamBuilder<ProfileResponse>(
        stream: homeBloc.subject.stream,
        builder: _asyncWidgetBuilder,
      ),
    );
  }

  Widget _asyncWidgetBuilder(context, AsyncSnapshot<ProfileResponse> snapshot) {
    if (snapshot.hasData) {
      if (snapshot.data == null) {
        return Text("Error");
      } else if (snapshot.data != null) {
        if (snapshot.data.results.length == 0) {
          return HomeWidget().emptyList();
        } else {
          return HomeWidget(context: context)
              .profileList(snapshot.data.results);
        }
      }
    } else {
      return Text("Carregando...");
    }
  }
}
