import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:vector_math/vector_math.dart';
import 'package:yuwaku_proto/main.dart';
import 'dart:ui' as ui;
import 'package:yuwaku_proto/map_painter.dart';
import 'dart:math' as math;
import 'package:yuwaku_proto/database.dart';
import 'package:yuwaku_proto/gameclear.dart';
import 'package:flutter/material.dart' as prefix;
import 'package:bubble/bubble.dart';
import 'map_painter.dart';// Colorsを使う時はprefix.Colors.~と使ってください
import 'package:geolocator/geolocator.dart';

/// アセットのパスからui.Imageをロード
Future<ui.Image> loadUiImage(String imageAssetPath) async {
  final ByteData data = await rootBundle.load(imageAssetPath);
  final Completer<ui.Image> completer = Completer();
  ui.decodeImageFromList(Uint8List.view(data.buffer), (ui.Image img) {
    return completer.complete(img);
  });
  return completer.future;
}

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
      final rawStr =
          (await imageDb.querySearchRows(this.name))[0]['image']! as String;
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
}

/// マップページのステートフルウィジェット
class MapPage extends StatefulWidget {
  /// コンストラクタ
  MapPage({Key? key, required this.title}) : super(key: key);
  final String title; /// ページタイトル

  /// 描画
  @override
  _MapPageState createState() => _MapPageState();
}

/// マップのステート
class _MapPageState extends State<MapPage> {

  final imageDb = ImageDBProvider.instance;
  bool is_clear = true;
  ui.Image? _mapImage;/// マップの画像
  double _moveX = 0;/// x軸の移動を保持

  MapPainter? _mapPainter = null;


  /// マップの場所情報の一覧
  final _mapItems = <MapItem>[
    MapItem('湯涌稲荷神社', 36.4859822, 136.7560359, Offset(1254, 292),
        'assets/images/img1_gray.png', Rect.fromLTWH(650, 182, 300, 300)),
    MapItem('総湯', 36.4857904, 136.7575357, Offset(1358, 408),
        'assets/images/img2_gray.png', Rect.fromLTWH(820, 820, 300, 300)),
  ];

  /// アセット(画像等)の取得
  Future<void> _getAssets() async {
    final ui.Image img = await loadUiImage('assets/images/map_img.png');
    this._mapPainter = MapPainter(img, _getMoveX, _mapItems);
    for (var item in _mapItems) {
      await item.loadInitialImage();
    }

    if(mounted){ /// WidgetTreeにWidgetが存在するかの判断
      setState(() => {
        _mapImage = img
      });
    }
  }

  /// x軸の移動情報を返す
  double _getMoveX() {
    return _moveX;
  }

  /// asyncの初期化用
  @override
  void initState() {
    super.initState();
    _getAssets();
  }

  Future clearUpdate() async {
    final count = await imageDb.countImage();
    if(mounted) {
      setState(() => {
        this.is_clear = count >= _mapItems.length
      });
    }
  }


  /// 見た目
  @override
  Widget build(BuildContext context) {
    final Size mediaSize = MediaQuery.of(context).size; // 画面の取得
    clearpage pageClear = new clearpage(mediaSize.width, mediaSize.height);

    final AppBar appBar = AppBar(
        title: Text(widget.title,
            style: TextStyle(color: prefix.Colors.black87))); // ヘッダ部分のUIパーツ

    final mediaHeight = mediaSize.height - appBar.preferredSize.height; // キャンバス部分の高さ

    clearUpdate();

    if ( _mapImage != null ) {
      this._mapPainter = MapPainter(_mapImage!, _getMoveX, _mapItems);
    }

    if (!this.is_clear) {
      // UI部分
      return Scaffold(
        appBar: appBar,
        body: Stack(
          children: <Widget>[
            Center(
              //_mapImage == null ? // マップ画像の読み込みがない場合はTextを表示
              child: _mapImage == null ? Text('Loading...', style: TextStyle(
                  fontSize: 30, fontWeight: FontWeight.bold
              )) : // ロード画面

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
      return Scaffold(
        appBar: appBar,
        body: Stack(
          children: [
            _mapImage == null ? Center(
                child: Text('Loading...',
                    style: TextStyle(
                    fontSize: 30, fontWeight: FontWeight.bold))
            ):
            pageClear,
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
    final widthsize = MediaQuery.of(context).size.width; // 横のスマホサイズの取得
    final heightsize = MediaQuery.of(context).size.height; // 縦のスマホサイズの取得

    return Container(
      height: widthsize / 6,
      margin: EdgeInsets.fromLTRB(heightsize / 8, heightsize / 1.5, 0, 0),

      // 透過処理
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 1000),
        opacity: _myOpacity,
        child: Bubble(

          // ヒント表示のテキストの空白部分のサイズ
          padding: BubbleEdges.only(left: 5, right: 5),
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
          // 出っ張っている所の指定
          nip: BubbleNip.leftBottom,
        ),
      ),
    );
  }
}

@override
Widget build(BuildContext context) {
  return Container();
}
