import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:ui' as ui;
import 'package:yuwaku_proto/map_painter.dart';
import 'package:yuwaku_proto/database.dart';
import 'package:yuwaku_proto/gameclear.dart';
import 'package:flutter/material.dart' as prefix;
import 'package:bubble/bubble.dart';
import 'map_painter.dart'; // Colorsを使う時はprefix.Colors.~と使ってください
import 'package:geolocator/geolocator.dart';
import 'homepage_component/homePage_Item.dart';

/// 場所情報
class MapItem {
  final String name;/// 場所の名前
  final double latitude;/// 緯度
  final double longitude;/// 経度
  final Offset position;/// 画像上の座標
  final String initialImagePath;/// イラストのパス
  final String posImage; ///　場所の写真
  double? distance;/// 距離
  ui.Rect photoRect;/// 画像の四角
  ui.Image? initialImage;
  final imageDb = ImageDBProvider.instance;
  ui.Image? photoImage;/// 初期化時のイラスト

  /// イニシャライズ
  MapItem(this.name, this.latitude, this.longitude, this.position,
      this.initialImagePath, this.photoRect, this.posImage);

  /// 初期画像のロード
  Future loadInitialImage() async {
    initialImage = await loadUiImage(initialImagePath);
    if (await imageDb.isExist(this.name)) {

      final rawStr = (await imageDb.querySearchRows(this.name))[0]['image'].toString();

      Uint8List raw = base64.decode(rawStr);
      ui.decodeImageFromList(raw, (ui.Image img) => {this.photoImage = img});
    }
  }

  /// 表示すべき画像を返す
  ui.Image? getDisplayImage() {
    if (photoImage == null) {
      return initialImage;
    }
    return photoImage;
  }

  /// image ウィジェットとして画像を返す
  Future<Image?> getDisplayImageToImageWidget() async {
    try {
      final img = this.getDisplayImage();
      if (img == null) return null;
      ByteData byteData =
          (await img.toByteData(format: ui.ImageByteFormat.png))!;
      final pngBytes = byteData.buffer.asUint8List();
      return Image.memory(pngBytes, fit: BoxFit.cover);
    } catch (e) {
      return null;
    }
  }

  /// 座標系をマップ画像上からデバイス上へ変換
  ui.Rect getPhotoRectForDeviceFit(double scale, double moveX) {
    return Rect.fromLTWH(photoRect.left * scale - moveX, photoRect.top * scale,
        photoRect.width * scale, photoRect.height * scale);
  }

  /// タップ判定をしてタップの場合はタップ処理をする
  bool didTappedImageTransition(double scale, double moveX, Offset tapLoc) {
    final tapX = tapLoc.dx;
    final tapY = tapLoc.dy;
    final rect = getPhotoRectForDeviceFit(scale, moveX);

    if (rect.left <= tapX &&
        tapX <= rect.right &&
        rect.top <= tapY &&
        tapY <= rect.bottom) {
      return true;
    }
    return false;
  }

  /// 距離を図る
  void setDistance(Position position) {
    this.distance = Geolocator.distanceBetween(
        position.latitude, position.longitude, this.latitude, this.longitude);
  }

  /// 近接判定
  bool isProximity(double range) {
    if (this.distance == null) {
      return false;
    } else {
      return this.distance! <= range;
    }
  }

  /// アセットのパスからui.Imageをロード
  static Future<ui.Image> loadUiImage(String imageAssetPath) async {
    final ByteData data = await rootBundle.load(imageAssetPath);
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(Uint8List.view(data.buffer), (ui.Image img) {
      return completer.complete(img);
    });
    return completer.future;
  }
}


/// マップページのステートフルウィジェット
class MapPage extends StatefulWidget {
  MapPage({Key? key, required this.title}) : super(key: key);
  final String title;

  /// ページタイトル

  @override
  _MapPageState createState() => _MapPageState();
}

/// マップのステート
class _MapPageState extends State<MapPage> {
  final imageDb = ImageDBProvider.instance;
  bool is_clear = true;
  late ui.Image _mapImage; // マップの画像
  late ui.Image _cameraIconImg;
  double _moveX = 0; // x軸の移動を保持
  late MapPainter _mapPainter;
  late clearpage pageClear;

  late Future<void> _initializeImageFuture;  // 画像を読み込み完了を検知する

  /// マップの場所情報の一覧
  final _mapItems = <MapItem>[
    /*MapItem('湯涌稲荷神社', 36.4856770,136.7582343, Offset(1254, 292),
        'assets/images/img1_gray.png', Rect.fromLTWH(650, 182, 280, 280)),*/
    MapItem(
            '総湯',
            36.485425901995455, 136.75758738535384, Offset(1358, 408),
        'assets/images/img2_gray.png', Rect.fromLTWH(1000, 820, 280, 280),
        'assets/images/KeigoSirayu.png'
    ),
    MapItem(
        '氷室',
        36.48346516395541, 136.75701193508996, Offset(1881, 512),
        'assets/images/himurogoya_gray.png',
        Rect.fromLTWH(1720, 620, 280, 280), 'assets/images/HimuroGoya.png'
    ),
    MapItem(
        '足湯(立派な方)', 36.48582537854954, 136.7574341842218, Offset(1275, 385),
        'assets/images/asiyu(temp)_gray.png', Rect.fromLTWH(1500, 60, 280, 280),
        'assets/images/Asiyu(temp).png'
    ),
    /* MapItem('足湯(湯の出)', 36.48919374904115, 136.75588850463596, Offset(505, 690),
        'assets/images/Asiyu(temp).png', Rect.fromLTWH(750, 80, 280, 280)),
        */
    MapItem('みどりの里',
            36.49050881078798, 136.75404574490975, Offset(239, 928),
            'assets/images/MidorinoSato.png', Rect.fromLTWH(280, 850, 280, 280),
            'assets/images/MidorinoSato.png',
    ),
    MapItem('湯涌夢二館',
            36.48584951599308, 136.75738876226737, Offset(1250, 425),
            'assets/images/yumejikan_gray.png', Rect.fromLTWH(580, 80, 280, 280),
            'assets/images/Yumezikan.png'
    ),
  ];


  /// アセット(画像等)の取得
  Future<void> _getAssets() async {
    final ui.Image img = await MapItem.loadUiImage('assets/images/map_img.png');
    final ui.Image cameraIconImg = await MapItem.loadUiImage('assets/images/camera_red.png');
    this._mapPainter = MapPainter(img, cameraIconImg, _getMoveX, _mapItems);
    for (var item in _mapItems) {
      await item.loadInitialImage();
    }

    _mapImage = img;
    _cameraIconImg = cameraIconImg;

    await clearUpdate();
  }

  /// x軸の移動情報を返す
  double _getMoveX() => _moveX;

  @override
  void initState() {
    super.initState();
    pageClear = clearpage(0, 0, _mapItems);
    _initializeImageFuture = _getAssets(); // 画像の読み込み

    MapPainter.determinePosition()
        .then((_) {
          Geolocator.getPositionStream().listen((location) {
            for(final item in _mapItems)
              item.setDistance(location); // 距離関係を更新する
          });
        }).catchError((_) => _dialogLocationLicense());
  }

  /// スポットの写真を全て撮影したかチェックする
  Future<void> clearUpdate() async {
    final count = await imageDb.countImage();
    setState(() => this.is_clear = count >= _mapItems.length);
  }

  @override
  Widget build(BuildContext context) {
    final Size mediaSize = MediaQuery.of(context).size; // 画面の取得
    final mediaHeight = mediaSize.height - kToolbarHeight; // キャンバス部分の高さ
    final mediaWidth = mediaSize.width;

    return Scaffold(
      appBar: AppBar(title: Text(widget.title, style: TextStyle(color: prefix.Colors.black87))),
      body: FutureBuilder<void>(
        future: _initializeImageFuture,
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done) {
            if (!this.is_clear) {
              this._mapPainter = MapPainter(_mapImage, _cameraIconImg, _getMoveX, _mapItems);

              return Container(
                height: mediaHeight,
                width: mediaWidth,

                child: Column(
                  children: [
                    Flexible(
                      flex: 3,
                      child: GestureDetector(
                        onTapUp: (details) {
                          // タップ時の処理
                          // 高さを基準にした画像の座標系からデバイスへの座標系への変換倍率
                          for (var item in _mapItems) { // TODO: 実際に現地で検証して
                            if (item.isProximity(30)) {
                              // 場所ごとのタップの判定処理(タップ時は遷移)
                              if (item.didTappedImageTransition(this._mapPainter.scale, _getMoveX(), details.localPosition)) {
                                Navigator.of(context).pushNamed('/camera_page', arguments: item).then((_) async => await clearUpdate());
                                break;
                              }
                            }
                          }
                        },
                        onPanUpdate: (DragUpdateDetails details) { // スクロール時の処理
                          // スクロールを適用した場合の遷移先X
                          final next = _moveX - details.delta.dx;
                          setState(() {
                            // 高さを基準にした画像の座標系からデバイスへの座標系への変換倍率
                            // スクロールできない場所などを考慮した補正をかけてメンバ変数に代入
                            _moveX = min(max(next, 0), _mapImage.width * this._mapPainter.scale - mediaSize.width);
                          });
                        },
                        child: CustomPaint(
                          // キャンバス本体
                          size: Size(mediaSize.width, mediaHeight), // サイズの設定(必須)
                          painter: this._mapPainter, // ペインター
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                            for(var itemDist in _mapItems)
                            Card(
                              child: Column(
                                children: [
                                  Container(
                                    height: mediaHeight/8,
                                    width: mediaWidth/2.5,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5.0),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(itemDist.posImage),
                                        )
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment(1,1),
                                    width: mediaWidth/3,
                                    height: mediaHeight/30,
                                    child: Text(
                                      itemDist.name,
                                    ),
                                  ),

                                  itemDist.distance != null ?
                                  Container(
                                    alignment: Alignment(1,1),
                                    width: mediaWidth/3,
                                    height: mediaHeight/50,
                                    child: Text(
                                      itemDist.distance!.toStringAsFixed(1)
                                    ),
                                  ):
                                  Container(
                                    width: mediaWidth/3,
                                    height: mediaHeight/50,
                                    child: Text(
                                      'Not Found Distance'
                                    ),
                                  )
                                ],
                              ),
                            ),
                        ],
                        shrinkWrap: true,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              this.pageClear.width = mediaSize.width;
              this.pageClear.height = mediaSize.height;

              return Stack(
                children: [
                  pageClear,
                  ElevatedButton(
                    onPressed: () {
                      imageDb.deleteAll();
                      for (var item in _mapItems) {
                        item.photoImage = null;
                      }
                      clearUpdate();
                    },
                    child: const Text('データ消去'),
                  ),
                ],
              );
            }
          } else if(snapshot.hasError) {
            return Center(child: Text('アプリを再起動してください'));
          } else {
            return Center(
              child: Column(
                children: <Widget>[
                  const CircularProgressIndicator(),
                  const Text('Loading...', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  /// 位置情報が拒否されている時、「位置情報を許可する」ダイアログを表示する
  Future<void> _dialogLocationLicense() async {
    var result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        if (Platform.isAndroid) {
          return AlertDialog(
            title: Text('位置情報を許可する'),
            content: Text('設定でアプリに位置情報を許可します。'),
            actions: <Widget>[
              TextButton(
                  child: Text('Cancel'),
                  onPressed: () => Navigator.of(context).pop(false)),
              TextButton(
                  child: Text('OK'),
                  onPressed: () => Navigator.of(context).pop(true)),
            ],
          );
        }

        // iOS側の動作
        return CupertinoAlertDialog(
          title: Text('位置情報を許可する'),
          content: Text('設定でアプリに位置情報を許可します。'),
          actions: <Widget>[
            CupertinoDialogAction(
                child: Text('Cancel'),
                isDestructiveAction: true,
                onPressed: () => Navigator.of(context).pop(false)),
            CupertinoDialogAction(
                child: Text('OK'),
                onPressed: () => Navigator.of(context).pop(true))
          ],
        );
      },
    );

    if (result == null) return; // unwrap
    if (result) await Geolocator.openAppSettings(); // 'OK'を選択した時、設定画面を開く
  }
}

