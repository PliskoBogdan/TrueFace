import 'package:flutter/material.dart';

import '../widgets/Add_Photos.dart';
import '../widgets/Add_Photo.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = '/profile';
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController _name = TextEditingController();
  TextEditingController _bio = TextEditingController();
  TextEditingController _nickname = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Settings'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person),
                        Text(
                          'Public info',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Divider(),
                    TextFormField(
                      controller: _name,
                      decoration: InputDecoration(
                          labelText: 'Name', hintText: 'Your public name'),
                    ),
                    TextFormField(
                      controller: _bio,
                      decoration: InputDecoration(
                          labelText: 'Bio',
                          hintText: 'Write something good about you'),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.photo_camera),
                        Text(
                          'Add Photos',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    AddPhotos(),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.security),
                        Text(
                          'Ingognito info',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: AddPhoto(),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: TextFormField(
                              controller: _nickname,
                              decoration: InputDecoration(
                                  labelText: 'Nickname',
                                  hintText: 'Your ingognito name'),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
