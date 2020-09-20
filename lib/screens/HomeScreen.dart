import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/Comments.dart';
import '../providers/Auth.dart';
import '../models/User.dart';

import '../widgets/Drawer.dart';
import '../widgets/Rating.dart';
import '../widgets/Comments.dart';
import '../widgets/UserCard.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<Auth>(context, listen: false).user;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CommentsProvider(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text('TrueFace'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                UserCard(),
                Rating(
                  ratings: user.rating,
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    user.bio,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                Comments(),
              ],
            ),
          ),
        ),
        endDrawer: AppDrawer(),
      ),
    );
  }
}
