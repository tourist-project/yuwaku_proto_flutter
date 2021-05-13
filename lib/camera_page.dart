import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';


class CameraPage extends StatefulWidget {
  CameraPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {

  File?  _image;
  final picker = ImagePicker();


  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        // ignore: unnecessary_null_comparison
        child: _image == null ? Text('No Selected') : Image.file(_image!),

      ),

      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        child: Icon(Icons.add_a_photo),
      ),

    );

  }
}