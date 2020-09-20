import 'package:flutter/material.dart';

enum CommentRatings {
  Like,
  Dislike,
}

class CommentProvider with ChangeNotifier {
  final int id;
  final String text;
  final String imageUrl;
  final String userNickname;
  int rating;
  CommentRatings isChanged;

  CommentProvider({
    @required this.id,
    @required this.text,
    @required this.imageUrl,
    @required this.userNickname,
    this.rating = 0,
    this.isChanged,
  });

  void toggleIsChanged(CommentRatings value) {
    if (isChanged != null) return;
    isChanged = value;
    notifyListeners();
  }

  void increaseRating() {
    if (isChanged == null) {
      rating += 1;
      notifyListeners();
    }
  }

  void decreaseRating() {
    if (isChanged == null) {
      rating -= 1;
      notifyListeners();
    }
  }
}
