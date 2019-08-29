import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite_test/model/breed/breed.dart';
import 'package:sqflite_test/view/breeds/breed-item.dart';
import 'package:sqflite_test/view/breeds/breeds-block.dart';

class BreedsWidgets {
  BuildContext context;
  BreedsWidgets({this.context});

  Container mainContent() {
    return Container(
      child: StreamBuilder<List<Breed>>(
        stream: bloc.subject.stream,
        builder: (BuildContext context, AsyncSnapshot<List<Breed>> snapshot) {
          if (snapshot.hasData) {
            return gridList(snapshot.data);
          } else {
            return requestingData();
          }
        },
      ),
    );
  }

  Container requestingData() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Container gridList(List<Breed> list) {
    return Container(
      child: streamItems(list),
    );
  }

  StreamBuilder<bool> streamItems(List<Breed> list) {
    return StreamBuilder<bool>(
      stream: bloc.subjectForEnableMultiSelect.stream,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return gridView(list, snapshot);
      },
    );
  }

  GridView gridView(List<Breed> list, AsyncSnapshot<bool> snapshot) {
    return GridView.count(
      crossAxisCount: 4,
      cacheExtent: double.infinity,
      children: List.generate(
        list.length,
        (index) {
          var breed = list[index];
          if (snapshot.data == true) {
            return itemMultiSelectedEnable(breed);
          } else {
            return breedItem(breed, selectionModeEnable: false);
          }
        },
      ),
    );
  }

  StreamBuilder<List<Breed>> itemMultiSelectedEnable(Breed breed) {
    return StreamBuilder<List<Breed>>(
      stream: bloc.subjectAuxForRemoveItems.stream,
      builder: (BuildContext context, AsyncSnapshot<List<Breed>> listSnapshot) {
        if (listSnapshot.hasData) {
          if (listSnapshot.data.contains(breed)) {
            return breedItem(breed, isSelected: true);
          } else {
            return breedItem(breed);
          }
        } else {
          return breedItem(breed);
        }
      },
    );
  }

  BreedItem breedItem(Breed breed,
      {bool selectionModeEnable = true, bool isSelected = false}) {
    return BreedItem(
      breed: breed,
      isSelectedModeEnable: selectionModeEnable,
      itemSelect: isSelected,
    );
  }
}
