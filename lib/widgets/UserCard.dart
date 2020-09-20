import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../providers/Auth.dart';
import '../models/User.dart';

import './Carousel.dart';

class UserCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User _user = Provider.of<Auth>(context, listen: false).user;
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Carousel(
            userPhotos: _user.photos,
          ),
        ),
        Text(
          _user.name,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
