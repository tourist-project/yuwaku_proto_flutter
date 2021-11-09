import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:image_picker/image_picker.dart';
import 'package:sqflite/sqflite.dart';
import 'package:yuwaku_proto/map_page.dart';
import 'package:yuwaku_proto/database.dart';

import 'package:share_plus/share_plus.dart';

import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';


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
  final picker = ImagePicker();
  final imageDb = ImageDBProvider.instance;
  Image? _dstStampImage;

  void initState() {
    super.initState();
    _loadStampImage();
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
        child: _dstStampImage,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  /// CameraPageを開いた時の初期画像を呼び出す
  Future<void> _loadStampImage() async {
    Image _srcStampImage = Image.asset(mapItem.initialImagePath);
    final listDB = await imageDb.queryAllRows();

    for (var num = 0; num < listDB.length; num++) {
      // SQLに画像が保存されている
      if(listDB[num]['state'] == mapItem.name) {
        final sqlImageFile = await _writeLocalImage(base64.decode(listDB[num]['image']));
        _srcStampImage = Image.file(sqlImageFile);
        break;
      }
    }

    setState((){
      _dstStampImage = _srcStampImage;
    });
  }

  /// カメラで写真撮影時の処理
  Future<void> getImage() async {
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

      ui.decodeImageFromList(data, (ui.Image img) {
        mapItem.photoImage = img;
      });

      await _writeLocalImage(data);
      setState((){
        _dstStampImage = Image.memory(data);
      });
    }
  }

  /// スポット名や画像の共有処理
  Future<void> _onShare(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    final stampPath = await _fetchLocalImage();

    List<String> list = [stampPath.path];
    await Share.shareFiles(
        list,
        text: '${mapItem.name}',
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }

  /// 端末のパスを取得
  Future<String> get _getLocalPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  /// 端末に画像を保存する
  Future<File> _writeLocalImage(Uint8List data) async {
    final path = await _getLocalPath;
    final imagePath = '$path/image.png';
    File imageFile = File(imagePath);

    final byte = ByteData.view(data.buffer);
    final buffer = byte.buffer;
    final localFile = await imageFile.writeAsBytes(buffer.asUint8List(byte.offsetInBytes, byte.lengthInBytes));
    return localFile;
  }

  /// 端末に保存した画像を取得する。
  Future<File> _fetchLocalImage() async {
    final path = await _getLocalPath;
    final imagePath = '$path/image.png';
    return File(imagePath);
  }
}