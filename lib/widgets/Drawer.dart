import 'package:flutter/material.dart';
import '../screens/LoginScreen.dart';
import '../screens/ProfileScreen.dart';

import 'package:provider/provider.dart';
import '../providers/Auth.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text(''),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Profile Settings'),
            onTap: () {
              Navigator.of(context).pushNamed(ProfileScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.subdirectory_arrow_left),
            title: Text('LogOut'),
            onTap: () {
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
