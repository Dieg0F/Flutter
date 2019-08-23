import 'package:flutter/material.dart';
import 'package:pfeed/models/profile.dart';
import 'package:pfeed/routes/routes.dart';
import 'package:pfeed/views/widgets/widgets.dart';

class HomeWidget {
  BuildContext context;

  HomeWidget({this.context});

  Center emptyList() {
    return Center(
      child: basicText("Nenhum perfil encontrado", 20, Colors.black26),
    );
  }

  Container profileList(List<Profile> profiles) {
    return Container(
      child: ListView.builder(
          itemCount: profiles.length,
          itemBuilder: (context, i) {
            return profileItem(profiles[i]);
          }),
    );
  }

  Container profileItem(Profile profile) {
    return Container(
      margin: new EdgeInsets.all(8),
      child: InkResponse(
        child: Container(
          child: profileItemContent(profile),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(new Radius.circular(5)),
            boxShadow: [
              new BoxShadow(
                color: Colors.black26,
                blurRadius: 0.5,
                offset: new Offset(0, 0.8),
              )
            ],
          ),
        ),
        onTap: () {
          Routes(context: context).toProfile(profile);
        },
      ),
    );
  }

  Container profileItemContent(Profile profile) {
    var profileName = profile.name.first + " " + profile.name.last;

    return Container(
      padding: new EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          profileItemContentAvatar(profileName, profile.picture),
          profileItemContentAbout(profile.about),
        ],
      ),
    );
  }

  Row profileItemContentAvatar(String profileName, String profilePhoto) {
    return Row(
      children: <Widget>[
        Container(
          margin: new EdgeInsets.only(
            right: 16,
          ),
          child: CircleAvatar(
            backgroundImage: NetworkImage(profilePhoto),
          ),
        ),
        basicText(profileName, 20, Colors.black45)
      ],
    );
  }

  Container profileItemContentAbout(String about) {
    return Container(
      margin: new EdgeInsets.only(
        top: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          basicText("About me:", 20, Colors.black45),
          spaceHorizontal(10),
          basicText(about, 18, Colors.black38)
        ],
      ),
    );
  }
}
