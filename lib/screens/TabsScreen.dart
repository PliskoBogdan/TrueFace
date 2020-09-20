import 'package:flutter/material.dart';

import './HomeScreen.dart';
import './HistoryScreen.dart';

class TabsScreen extends StatefulWidget {
  static String routeName = '/tabs';
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int tabIndex = 0;
  List<Widget> listScreens;
  @override
  void initState() {
    super.initState();
    listScreens = [
      HomeScreen(),
      HistoryScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listScreens[tabIndex],
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey[400],
          backgroundColor: Theme.of(context).primaryColor,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: tabIndex,
          onTap: (int index) {
            setState(() {
              tabIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Tab1'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              title: Text('Tab2'),
            ),
          ]),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
