import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite_test/model/breed/breed.dart';
import 'package:sqflite_test/routes/routes.dart';
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
      child: GridView.count(
        crossAxisCount: 4,
        cacheExtent: double.infinity,
        children: List.generate(
          list.length,
          (index) {
            return gridItem(list[index]);
          },
        ),
      ),
    );
  }

  Container gridItem(Breed breed) {
    return Container(
      child: InkResponse(
        onTap: () {
          Routes(context: context).toBreedDetails(breed);
        },
        child: Padding(
          padding: new EdgeInsets.all(0.5),
          child: Center(
            child: Text(breed.name),
          ),
        ),
      ),
    );
  }
}
