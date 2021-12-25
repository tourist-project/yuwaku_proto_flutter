import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:ui' as ui;
import 'package:yuwaku_proto/map_painter.dart';
import 'package:yuwaku_proto/database.dart';
import 'package:yuwaku_proto/gameclear.dart';
import 'package:flutter/material.dart' as prefix;
import 'package:bubble/bubble.dart';
import 'map_painter.dart';// Colorsを使う時はprefix.Colors.~と使ってください
import 'package:geolocator/geolocator.dart';


/// 場所情報
class MapItem {
  final String name;/// 場所の名前
  final double latitude;/// 緯度
  final double longitude;/// 経度
  final Offset position;/// 画像上の座標
  final String initialImagePath;/// イラストのパス
  double? distance; /// 距離
  ui.Rect photoRect;/// 画像の四角
  ui.Image? initialImage;

  final imageDb = ImageDBProvider.instance;/// 初期化時のイラスト
  ui.Image? photoImage;

  /// イニシャライズ
  MapItem(this.name, this.latitude, this.longitude, this.position,
      this.initialImagePath, this.photoRect);

  /// 初期画像のロード
  Future loadInitialImage() async {
    initialImage = await loadUiImage(initialImagePath);
    if (await imageDb.isExist(this.name)) {
      final rawStr = (await imageDb.querySearchRows(this.name))[0]['image']! as String;
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
      ByteData byteData = (await img.toByteData(format: ui.ImageByteFormat.png))!;
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

    if (rect.left <= tapX && tapX <= rect.right &&
        rect.top <= tapY && tapY <= rect.bottom) {
      return true;
    }
    return false;
  }

  /// 距離を図る
  void setDistance(Position position) {
    this.distance = Geolocator.distanceBetween(position.latitude, position.longitude, this.latitude, this.longitude);
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
  final String title; /// ページタイトル

  @override
  _MapPageState createState() => _MapPageState();
}

/// マップのステート
class _MapPageState extends State<MapPage> {
  final imageDb = ImageDBProvider.instance;
  bool is_clear = true;
  ui.Image? _mapImage; // マップの画像
  ui.Image? _cameraIconImg;
  double _moveX = 0; // x軸の移動を保持
  MapPainter? _mapPainter = null;
  clearpage? pageClear = null;
  bool is_reset_images = false;


  /// マップの場所情報の一覧
  final _mapItems = <MapItem>[
    /*MapItem('湯涌稲荷神社', 36.4856770,136.7582343, Offset(1254, 292),
        'assets/images/img1_gray.png', Rect.fromLTWH(650, 182, 280, 280)),*/
    MapItem('総湯', 36.485425901995455,  136.75758738535384, Offset(1358, 408),
        'assets/images/img2_gray.png', Rect.fromLTWH(1000, 820, 280, 280)),
    MapItem('氷室', 36.48346516395541, 136.75701193508996, Offset(1881, 512),
        'assets/images/himurogoya_gray.png', Rect.fromLTWH(1720, 620, 280, 280)),
    MapItem('足湯(立派な方)', 36.48582537854954, 136.7574341842218, Offset(505, 690),
        'assets/images/asiyu(temp)_gray.png', Rect.fromLTWH(750, 80, 280, 280)),
   /* MapItem('足湯(湯の出)', 36.48919374904115, 136.75588850463596, Offset(505, 690),
        'assets/images/Asiyu(temp).png', Rect.fromLTWH(750, 80, 280, 280)),
        */
    /*MapItem('みどりの里', 36.49050881078798, 136.75404574490975, Offset(239, 928),
        'assets/images/MidorinoSato.png', Rect.fromLTWH(280, 850, 280, 280))*/
    MapItem('湯涌夢二館', 36.48584951599308, 136.75738876226737, Offset(1250, 425),
        'assets/images/yumejikan_gray.png', Rect.fromLTWH(1500, 60, 280, 280)),
  ];


  /// アセット(画像等)の取得
  Future<void> _getAssets() async {
    final ui.Image img = await MapItem.loadUiImage('assets/images/map_img.png');
    final ui.Image cameraIconImg = await MapItem.loadUiImage('assets/images/camera_red.png');
    this._mapPainter = MapPainter(img, cameraIconImg, _getMoveX, _mapItems);
    for (var item in _mapItems) {
      await item.loadInitialImage();
    }

    if(mounted){ /// WidgetTreeにWidgetが存在するかの判断
      setState(() => {
        _mapImage = img,
        _cameraIconImg = cameraIconImg
      });
    }

    this.pageClear = clearpage(0, 0, _mapItems);
  }

  /// x軸の移動情報を返す
  double _getMoveX() => _moveX;

  @override
  void initState() {
    super.initState();
    print('initState');
    MapPainter.determinePosition().catchError((_) => _dialogLocationLicense());
    _getAssets();
  }

  Future<void> clearUpdate() async {
    final count = await imageDb.countImage();
    if(mounted) {
      setState(() => {
        this.is_clear = count >= _mapItems.length
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size mediaSize = MediaQuery.of(context).size; // 画面の取得

    final AppBar appBar = AppBar(title: Text(widget.title, style: TextStyle(color: prefix.Colors.black87)));
    final mediaHeight = mediaSize.height - appBar.preferredSize.height; // キャンバス部分の高さ

    clearUpdate();

    if (_mapImage != null) {
      this._mapPainter = MapPainter(_mapImage!,_cameraIconImg!, _getMoveX, _mapItems);
    }

    if (!this.is_clear) {
      // UI部分
      return Scaffold(
        appBar: appBar,
        body: Stack(
          children: <Widget>[
            Center(
              child: _mapImage == null
                  ? Text('Loading...', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))
                  : // ロード画面

              GestureDetector(
                onTapUp: (details) { // タップ時の処理
                  // 高さを基準にした画像の座標系からデバイスへの座標系への変換倍率
                  for (var item in _mapItems) {
                    // TODO: 実際に現地で検証して
                    if (item.isProximity(30)) {
                      // 場所ごとのタップの判定処理(タップ時は遷移)
                      if (item.didTappedImageTransition(
                          this._mapPainter!.scale, _getMoveX(),
                          details.localPosition)) {
                        Navigator.of(context).pushNamed(
                            '/camera_page', arguments: item);
                        break;
                      }
                    }
                  }
                },
                onPanUpdate: (DragUpdateDetails details) { // スクロール時の処理
                  setState(() {
                    // スクロールを適用した場合の遷移先X
                    final next = _moveX - details.delta.dx;
                    // 高さを基準にした画像の座標系からデバイスへの座標系への変換倍率
                    // スクロールできない場所などを考慮した補正をかけてメンバ変数に代入
                    _moveX = min(max(next, 0),
                        _mapImage!.width * this._mapPainter!.scale -
                            mediaSize.width);
                  });
                },
                child: CustomPaint(
                  // キャンバス本体
                  size: Size(mediaSize.width, mediaHeight), // サイズの設定(必須)
                  painter: this._mapPainter!, // ペインター
                  child: Center(), // あったほうがいいらしい？？
                ),
              ),
            ),
            SnackBerPage(),
          ],
        ),
      );
    }else{
      if (!is_reset_images && pageClear != null) {
        this.pageClear!.width = mediaSize.width;
        this.pageClear!.height = mediaSize.height;
        this.is_reset_images = true;
      }
      return Scaffold(
        appBar: appBar,
        body: Stack(
          children: [
            _mapImage == null || pageClear == null
                ? Text('Loading...', style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold),
              textAlign: TextAlign.center
            )
            :
            pageClear!,
            ElevatedButton(
              onPressed: () {
                imageDb.deleteAll();
                for (var item in _mapItems) {
                  item.photoImage = null;
                }
              },
              child: const Text('もう一度'),
            ),
          ],
        ),
      );
    }
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

// ヒント内容
String hintText = randomHint();

String randomHint() => explainList[Random().nextInt(explainList.length)];

// ヒント内容
const explainList = ['森に囲まれた長い段差を乗り越えるとそこには', '川にかかった大きな橋、森を見守るような厳かな表情'];
int change = 0;

class SnackBerPage extends StatefulWidget {
  SnackBerPage() : super();
  @override
  _SnackBarPageState createState() => _SnackBarPageState(durationSecond: 3);
}

class _SnackBarPageState extends State<SnackBerPage> {

  final int durationSecond;
  _SnackBarPageState({required this.durationSecond});
  var _myOpacity = 0.5; // 透過値

  @override
  void initState() {
    Timer.periodic(Duration(seconds: durationSecond), _onTimer);
    super.initState();
  }

  void _onTimer(Timer timer) {
    if (mounted) {
      // 表示するヒントを決める変数にランダムに数字を代入
      hintText = randomHint();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width; // スマホの横幅
    final screenHeight = MediaQuery.of(context).size.height; // スマホの縦幅

    // 透過処理
    return Container(
      height: screenWidth / 6,
      margin: EdgeInsets.fromLTRB(screenHeight / 8, screenHeight / 1.5, 0, 0),
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 1000),
        opacity: _myOpacity,
        child: Bubble(
          padding: BubbleEdges.only(left: 5, right: 5), // ヒントの空白部分
          child: Container(
              alignment: Alignment.center,
              child: Text(
                explainList[change],
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              )
          ),
          nip: BubbleNip.leftBottom, // 出っ張っている所の指定
        ),
      ),
    );
  }
}

@override
Widget build(BuildContext context) {
  return Container();
}
