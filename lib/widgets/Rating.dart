import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Rating extends StatefulWidget {
  List<double> ratings;
  Rating({this.ratings});
  @override
  _RatingState createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  double get initialRating {
    var sum = widget.ratings.reduce((value, element) => value + element);
    return sum / widget.ratings.length;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RatingBar(
            initialRating: initialRating,
            itemCount: 5,
            itemBuilder: (context, index) {
              switch (index) {
                case 0:
                  return Text('😈');
                case 1:
                  return Text('💩');
                case 2:
                  return Text('😑');
                case 3:
                  return Text('☺️');
                case 4:
                  return Text('😇');
              }
            },
            onRatingUpdate: (rating) {
              setState(() {
                widget.ratings.add(rating);
              });
            }),
        Text(double.parse((initialRating).toStringAsFixed(2)).toString())
      ],
    );
  }
}
