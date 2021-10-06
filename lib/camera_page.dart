import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:image_picker/image_picker.dart';
import 'package:sqflite/sqflite.dart';
import 'package:yuwaku_proto/map_page.dart';
import 'package:yuwaku_proto/database.dart';

class CameraPage extends StatefulWidget {
  CameraPage({Key? key, required this.title, required this.mapItem}) : super(key: key);

  final String title;
  final MapItem mapItem;

  @override
  _CameraPageState createState() => _CameraPageState(mapItem);
}

class _CameraPageState extends State<CameraPage> {

  _CameraPageState(this.mapItem);

  final MapItem mapItem;
  File?  _image;
  final picker = ImagePicker();
  final imageDb = ImageDBProvider.instance;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      var data = await pickedFile.readAsBytes();
      final saveData = base64.encode(data);
      if ( await imageDb.isExist(mapItem.name) ) {
        await imageDb.updateImage(mapItem.name, saveData);
      } else {
        await imageDb.insert({
          'state': mapItem.name,
          'image': saveData
        });
      }

      print( await imageDb.queryRowCount() );
      ui.decodeImageFromList(data, (ui.Image img) {
        mapItem.photoImage = img;
      });
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        // ignore: unnecessary_null_comparison
        child: _image == null ? Text('No Selected ${mapItem.name}\'s image') : Image.file(_image!),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

}