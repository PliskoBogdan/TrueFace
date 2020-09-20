import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';

class Carousel extends StatelessWidget {
  final List<String> userPhotos;
  Carousel({this.userPhotos});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 300.0,
        viewportFraction: 1.0,
        enlargeCenterPage: false,
        autoPlay: true,
      ),
      items: userPhotos.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                i,
                fit: BoxFit.cover,
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
