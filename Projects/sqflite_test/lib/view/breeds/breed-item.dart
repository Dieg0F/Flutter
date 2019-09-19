import 'package:flutter/material.dart';
import 'package:sqflite_test/model/breed/breed.dart';
import 'package:sqflite_test/routes/routes.dart';
import 'package:sqflite_test/view/breeds/breeds-block.dart';

class BreedItem extends StatefulWidget {
  Breed breed;
  bool isSelectedModeEnable;
  bool itemSelect;
  BreedItem(
      {Key key,
      @required this.breed,
      @required this.isSelectedModeEnable,
      this.itemSelect})
      : super(key: key);

  _BreedItemState createState() => _BreedItemState();
}

class _BreedItemState extends State<BreedItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: gridItem(widget.breed),
    );
  }

  Container gridItem(Breed breed) {
    return Container(
      child: gridItemNotSelected(breed),
    );
  }

  InkResponse gridItemNotSelected(Breed breed) {
    if (widget.isSelectedModeEnable) {
      return InkResponse(
        onTap: () {
          bloc.breedItemSelected(breed);
        },
        onLongPress: () {
          print("Disabled Multiselect: " + widget.breed.name);
          bloc.enableMultiSelectItems(false);
        },
        child: gridItemContentSelected(breed),
        splashColor: Colors.teal,
      );
    } else {
      return InkResponse(
        onTap: () {
          Routes(context: context).toBreedDetails(breed);
        },
        onLongPress: () {
          print("Selected Started: " + widget.breed.name);
          bloc.enableMultiSelectItems(true);
          bloc.breedItemSelected(breed);
        },
        child: gridItemContent(breed),
        splashColor: Colors.red,
      );
    }
  }

  Container gridItemContent(Breed breed) {
    return Container(
      padding: new EdgeInsets.all(0.5),
      child: Center(
        child: Text(breed.name),
      ),
    );
  }

  Container gridItemContentSelected(Breed breed) {
    if (widget.itemSelect) {
      return Container(
        padding: new EdgeInsets.all(0.5),
        child: Center(
          child: Text(breed.name),
        ),
        color: Colors.grey,
      );
    } else {
      return Container(
        padding: new EdgeInsets.all(0.5),
        child: Center(
          child: Text(breed.name),
        ),
        color: Colors.blue,
      );
    }
  }
}
