import 'package:flutter/material.dart';
import 'package:pfeed/models/profile.dart';
import 'package:pfeed/views/widgets/widgets.dart';

class DetailsWidget {
  BuildContext context;

  DetailsWidget(this.context);

  Scaffold mainContent(Profile profile) {
    return Scaffold(
      appBar: appBar("Detalhes do perfil"),
      body: mainContainer(profile),
    );
  }

  Container mainContainer(Profile profile) {
    return Container(
      margin: new EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          profileAvatarSession(profile),
          profileAboutSession(profile),
        ],
      ),
    );
  }

  Container profileAvatarSession(Profile profile) {
    var profileName = profile.name.first + " " + profile.name.last;
    var ageString = profile.age.toString() + " anos";
    return Container(
      margin: new EdgeInsets.only(top: 24, left: 16, right: 16),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(profile.picture),
            radius: 50,
          ),
          spaceVertical(16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              basicText(profileName, 26, Colors.black38),
              basicText(ageString, 16, Colors.black38),
            ],
          ),
        ],
      ),
    );
  }

  Container profileAboutSession(Profile profile) {
    return Container(
      margin: new EdgeInsets.only(
        top: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          basicText("About me:", 20, Colors.black45),
          spaceHorizontal(10),
          basicText(profile.about, 18, Colors.black38)
        ],
      ),
    );
  }

  Container profilePhotos() {}
}
