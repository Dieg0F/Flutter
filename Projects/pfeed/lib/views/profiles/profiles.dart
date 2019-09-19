import 'package:flutter/material.dart';
import 'package:pfeed/models/profile.dart';
import 'package:pfeed/views/profiles/profiles-widgets.dart';
import 'package:pfeed/views/widgets/widgets.dart';

import 'profiles-bloc.dart';

class Profiles extends StatefulWidget {
  List<ProfileResponse> profiles = new List<ProfileResponse>();

  Profiles() {
    profiles = [];
  }

  _ProfilesState createState() => _ProfilesState();
}

class _ProfilesState extends State<Profiles> {
  _ProfilesState() {
    profilesBloc.getProfiles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("Perfis"),
      body: StreamBuilder<ProfileResponse>(
        stream: profilesBloc.subject.stream,
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
          return ProfilesWidget().emptyList();
        } else {
          return ProfilesWidget(context: context)
              .profileList(snapshot.data.results);
        }
      }
    } else {
      return Text("Carregando...");
    }
  }
}
