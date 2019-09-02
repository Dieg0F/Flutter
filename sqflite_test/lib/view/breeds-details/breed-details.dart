import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sqflite_test/model/breed/breed.dart';
import 'package:sqflite_test/routes/routes.dart';
import 'package:sqflite_test/view/breeds-details/breed-details-widgets.dart';
import 'package:sqflite_test/view/widgets/widgets.dart' as widgets;

import 'breed-details-bloc.dart';
import 'breed-details-popupmenu.dart';

class BreedDetails extends StatefulWidget {
  Breed breed;
  BreedDetails({Key key, @required this.breed}) : super(key: key);

  _BreedDetailsState createState() => _BreedDetailsState();
}

class _BreedDetailsState extends State<BreedDetails> {
  BreedDetailsWidgets breedDetailsWidgets;

  void _select(BreedDetailsPopupMenu popupMenuItem) {
    if (popupMenuItem.title == "Update") {
      print(widget.breed.name);
      Routes(context: context).toUpdateBreed(widget.breed);
    } else {
      bloc.showLoading();
      bloc.removeBreed(widget.breed.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    breedDetailsWidgets = new BreedDetailsWidgets(context: context);

    return StreamBuilder<bool>(
      stream: bloc.loading.stream,
      builder: (BuildContext context, AsyncSnapshot<bool> requestingSnapshot) {
        if (!requestingSnapshot.hasData) {
          return mainContent();
        } else {
          if (requestingSnapshot.data == true) {
            return StreamBuilder<String>(
              stream: bloc.subjectActions.stream,
              builder:
                  (BuildContext context, AsyncSnapshot<String> actionSnapshot) {
                if (actionSnapshot.hasData) {
                  print(actionSnapshot.data);
                  switch (actionSnapshot.data) {
                    case "Removing":
                      return onRequestingData();
                      break;
                    case "Removed":
                      return mainContent();
                      break;
                  }
                } else {
                  return onRequestingData();
                }
              },
            );
          } else {
            return mainContent();
          }
        }
      },
    );
  }

  Stack onRequestingData() {
    return Stack(
      children: <Widget>[
        mainContent(),
        Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
          color: Colors.white54,
        ),
      ],
    );
  }

  Scaffold mainContent() {
    return Scaffold(
      appBar: widgets.appBar(widget.breed.name, actions: [
        IconButton(
          icon: Icon(
            Icons.scanner,
            color: Colors.white70,
          ),
          onPressed: () {
            print("Icon Button Action");
          },
        ),
        PopupMenuButton<BreedDetailsPopupMenu>(
          onSelected: _select,
          itemBuilder: (BuildContext context) {
            return popupMenuItems.map((BreedDetailsPopupMenu popupMenuItem) {
              return PopupMenuItem<BreedDetailsPopupMenu>(
                value: popupMenuItem,
                child: Text(popupMenuItem.title),
              );
            }).toList();
          },
        ),
      ]),
      body: breedDetailsWidgets.body(widget.breed),
    );
  }
}
