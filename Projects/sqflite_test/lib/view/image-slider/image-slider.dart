import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageSlider extends StatelessWidget {
  String imagePath;
  ImageSlider({Key key, @required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: fullScreenSlider(context),
        backgroundColor: Colors.black,
      ),
    );
  }

  Container fullScreenSlider(BuildContext ctx) {
    return Container(
      child: Stack(
        children: <Widget>[
          carouselSlider(ctx),
          screenActionColumn(ctx),
        ],
      ),
      width: MediaQuery.of(ctx).size.width,
      height: MediaQuery.of(ctx).size.height,
    );
  }

  Column screenActionColumn(BuildContext ctx) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Center(
          child: InkResponse(
            onTap: () {
              Navigator.pop(ctx);
            },
            child: exitImageSliderButton(),
          ),
        ),
      ],
    );
  }

  Container exitImageSliderButton() {
    return Container(
      width: 60,
      height: 60,
      margin: new EdgeInsets.only(bottom: 50),
      decoration: BoxDecoration(
        border: new Border.all(
          color: Colors.white54,
          width: 2,
          style: BorderStyle.solid,
        ),
        borderRadius: new BorderRadius.all(
          new Radius.circular(100),
        ),
      ),
      child: Icon(
        Icons.close,
        size: 35,
        color: Colors.white54,
      ),
    );
  }

  CarouselSlider carouselSlider(BuildContext ctx) {
    return CarouselSlider(
      height: MediaQuery.of(ctx).size.height,
      items: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Image.file(
                File(imagePath),
                width: MediaQuery.of(context).size.width,
              ),
            );
          },
        );
      }).toList(),
      autoPlay: true,
      enableInfiniteScroll: false,
    );
  }
}
