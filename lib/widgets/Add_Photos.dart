import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class AddPhotos extends StatefulWidget {
  @override
  _AddPhotosState createState() => _AddPhotosState();
}

class _AddPhotosState extends State<AddPhotos> {
  List<File> _images = [];
  final _picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);

    setState(() {
      _images.add(File(pickedFile.path));
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      primary: false,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      crossAxisCount: 3,
      padding: const EdgeInsets.all(20),
      children: new List.generate(6, (index) {
        return GestureDetector(
          onTap: getImage,
          child: Container(
            color: Colors.black12,
            child: _images.asMap().containsKey(index)
                ? Image.file(
                    _images[index],
                    fit: BoxFit.cover,
                  )
                : Icon(Icons.add),
          ),
        );
      }),
    );
  }
}
