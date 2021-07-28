import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../data.dart';

var pathCheck;
var defaultImage = "assets/images/Айно.png";

class ImageHero extends StatefulWidget {              //Фото и его изменение
  @override
  _ImageHeroState createState() => _ImageHeroState();
}

class _ImageHeroState extends State<ImageHero> {
  var _image;
  final picker = ImagePicker();
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    pathCheck = pickedFile;

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        Provider.of<Data>(context, listen: false).saveImage(_image);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(children: [
        _imageFrame(),
        SizedBox(height: 10),
        FlatButton(
            onPressed: () => getImage(),
            child: Icon(Icons.add_photo_alternate_outlined)),
      ]),
    );
  }

  Widget _imageFrame() => Container(                           //рамка фотографии
      child: pathCheck != null
          ? Image.file(context.watch<Data>().getImage,
              width: 2480, height: 298, fit: BoxFit.cover)
          : Image.asset(defaultImage,
              width: 248, height: 298, fit: BoxFit.cover),
      alignment: Alignment.center,
      width: 250,
      height: 300,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          shape: BoxShape.rectangle,
          border: Border.all(
            width: 2,
            color: Colors.deepOrangeAccent,
          )));
}
