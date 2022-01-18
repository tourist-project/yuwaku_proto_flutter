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

import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image/image.dart' as img;

import 'package:flutter/services.dart';

import 'map_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:uuid/uuid.dart';

class CameraPageState extends ConsumerWidget {
  CameraPageState(this.mapItem, this.number);

  final MapItem mapItem;
  final int number;
  final picker = ImagePicker();
  final imageDb = ImageDBProvider.instance;


  img.Image? logo;

  @override
  Widget build(context, ref) {
    final checkPoint = ref.watch(mapItemListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera page', style: TextStyle(color: Colors.black87)),
        actions: <Widget>[
          IconButton(
            onPressed: () => _onShare(context),
            icon: const Icon(Icons.ios_share),
          ),
        ],
      ),
      body: Center(child: Image.asset(checkPoint[number].initialImagePath)),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final imagePath = await getImage();
          if(imagePath == null) return;
          ref.read(mapItemListProvider.notifier).replaceTheImage(name: mapItem.name, path: imagePath);
        },
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }

  /// ロゴ画像を取得する
  Future<void> _loadInitAsync() async {
    ByteData imageData = await rootBundle.load('assets/images/text_logo.png');
    logo = img.decodeImage(Uint8List.view(imageData.buffer));
  }

  /// カメラで写真撮影し、画像のパスを返す
  Future<String?> getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    await _loadInitAsync();
    if (pickedFile != null) {
      Uint8List data = await pickedFile.readAsBytes();

      List<int> values = data.buffer.asUint8List();
      img.Image? photo = img.decodeImage(values);
      if (photo != null && logo != null) {
        for (var i = 0; i < logo!.width-1; i++) {
          for (var j = 0; j < logo!.height-1; j++) {
            final px = logo!.getPixelSafe(i, j);
            if ( img.getAlpha(px) != 0 ) {
              photo.setPixelSafe(photo.width-logo!.width-30+i, photo.height-logo!.height-30+j, px);
            }
          }
        }
        data = Uint8List.fromList(img.encodePng(photo));
      }
      
      final saveData = base64.encode(img.encodePng(photo!));

      if (await imageDb.isExist(mapItem.name)) {
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

      final result_image = await ImageGallerySaver.saveImage(data);

      final imagePath = await _writeLocalImage(data);

      return imagePath.path;
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
    final uuid = Uuid().v4();
    final imagePath = '$path/$uuid.png';
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