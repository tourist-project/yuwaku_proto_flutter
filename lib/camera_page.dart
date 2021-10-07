import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:image_picker/image_picker.dart';
import 'package:yuwaku_proto/map_page.dart';

import 'package:share_plus/share_plus.dart';

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

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      var data = await pickedFile.readAsBytes();
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

        title: Text(widget.title, style: TextStyle(color: Colors.black87)),
        actions: <Widget>[
          IconButton(
            onPressed:  () => _onShare(context),
            icon: Icon(Icons.ios_share),
          ),
        ],

      ),
      body: Center(
        // ignore: unnecessary_null_comparison
        child: _image == null
            ? Text('No Selected ${mapItem.name}\'s image')
            : Image.file(_image!),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  void _onShare(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;

    if (_image != null) {
      List<String> list = [_image!.path];
      await Share.shareFiles(
          list,
          text: '${mapItem.name}',
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    } else {
      await Share.share(
          '${mapItem.name}',
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    }
  }

}