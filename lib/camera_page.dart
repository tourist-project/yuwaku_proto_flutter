import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:image_picker/image_picker.dart';
import 'package:yuwaku_proto/draw_logo.dart';
import 'package:yuwaku_proto/image_with_logo.dart';
import 'package:yuwaku_proto/map_page.dart';
import 'package:yuwaku_proto/database.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/services.dart';


class CameraPage extends StatefulWidget {
  CameraPage({Key? key, required this.title, required this.mapItem})
      : super(key: key);

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
  img.Image? logo;
  bool loadingFlag = false;
  ImageWithLogo? photoWithLogo;

  void initState() {
    super.initState();
    // _loadInitAsync();
    // _loadStampImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(color: Colors.black87)),
        actions: <Widget>[
          // IconButton(
          //   onPressed: () => _onShare(context),
          //   icon: Icon(Icons.ios_share),
          // ),
        ],
      ),
      body:
        Center(
          child: ImageWithLogo(picture: Image.asset('assets/images/HimuroGoya')),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  // Future<void> _loadInitAsync() async {
  //   ByteData imageData = await rootBundle.load('assets/images/text_logo.png');
  //   logo = img.decodeImage(Uint8List.view(imageData.buffer));
  // }

  /// CameraPageを開いた時の初期画像を呼び出す
  // Future<void> _loadStampImage() async {
  //   loadingFlag = true;
  //   final dblow = await imageDb.querySearchRows(mapItem.name);
  //   if (dblow.length > 0) {
  //     final byte = base64.decode(dblow[0]['image'] as String);
  //     await _writeLocalImage(byte);
  //     setState(() {
  //       photoWithLogo = ImageWithLogo(picture: Image.memory(byte));
  //       loadingFlag = false;
  //     });
  //   } else {
  //     setState(() {
  //       photoWithLogo = ImageWithLogo(picture: Image.asset(mapItem.initialImagePath));
  //       loadingFlag = false;
  //     });
  //   }
  //
  // }

  /// カメラで写真撮影時の処理
  Future<void> getImage() async {

    setState(() {
      loadingFlag = true;
    });

    final pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      Uint8List data = await pickedFile.readAsBytes();
      Image picture = Image.memory(data);

      photoWithLogo = ImageWithLogo(picture: picture);
    }

  }

  /// スポット名や画像の共有処理
  // Future<void> _onShare(BuildContext context) async {
  //   final box = context.findRenderObject() as RenderBox?;
  //   final stampPath = await _fetchLocalImage();
  //
  //   List<String> list = [stampPath.path];
  //   await Share.shareFiles(list,
  //       text: '${mapItem.name}',
  //       sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  // }

  /// 端末のパスを取得
  // Future<String> get _getLocalPath async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   return directory.path;
  // }
  //
  // /// 端末に画像を保存する
  // Future<File> _writeLocalImage(Uint8List data) async {
  //
  //   final path = await _getLocalPath;
  //   final imagePath = '$path/image.png';
  //   File imageFile = File(imagePath);
  //   final byte = ByteData.view(data.buffer);
  //   final buffer = byte.buffer;
  //   final localFile = await imageFile.writeAsBytes(
  //       buffer.asUint8List(byte.offsetInBytes, byte.lengthInBytes));
  //   return localFile;
  // }
  //
  // /// 端末に保存した画像を取得する。
  // Future<File> _fetchLocalImage() async {
  //
  //   final path = await _getLocalPath;
  //   final imagePath = '$path/image.png';
  //   return File(imagePath);
  // }

  /// 写真取った後の画面処理
  Widget selectedImage(){
    if(_dstStampImage == null){
      print('取得中ｘ');
      return Center(
        child: Image(
          image: AssetImage('assets/images/Loading.gif'),
        ),
      );
    }else if(_dstStampImage != null && loadingFlag == true){
      print('データ更新中');

      return Center(
          child: Image(
          image: AssetImage('assets/images/Loading.gif'),
          ),
      );
    }else{
      print('取得完了');
      return Center(
        child: _dstStampImage,
      );
    }

  }
}
