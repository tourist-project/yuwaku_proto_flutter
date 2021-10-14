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
import 'package:geolocator/geolocator.dart';

import 'package:yuwaku_proto/database.dart';

import 'package:flutter/material.dart' as prefix;
import 'package:bubble/bubble.dart';

import 'map_painter.dart';

/// Colorsを使う時はprefix.Colors.~と使ってください

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
  final String name;

  /// 場所の名前
  final double latitude;

  /// 緯度
  final double longitude;

  /// 経度
  final Offset position;

  /// 画像上の座標
  final String initialImagePath;

  /// イラストのパス
  ui.Rect photoRect;

  /// 画像の四角

  ui.Image? initialImage;


  void Function()? tapImageFunc; /// タップ時に動く関数
  final imageDb = ImageDBProvider.instance;
  /// 初期化時のイラスト
  ui.Image? photoImage;



  /// イニシャライズ
  MapItem(this.name, this.latitude, this.longitude, this.position,
      this.initialImagePath, this.photoRect,
      {tapImageFunc});

  /// 初期画像のロード
  Future loadInitialImage() async {
    initialImage = await loadUiImage(initialImagePath);
    if ( await imageDb.isExist(this.name) ) {
      final rawStr = (await imageDb.querySearchRows(this.name))[0]['image']! as String;
      Uint8List raw = base64.decode(rawStr);
      ui.decodeImageFromList(raw, (ui.Image img) => {
        this.photoImage = img
      });
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
  void onTapImage(double scale, double moveX, Offset tapLoc) {
    final tapX = tapLoc.dx;
    final tapY = tapLoc.dy;
    final rect = getPhotoRectForDeviceFit(scale, moveX);
    if (rect.left <= tapX &&
        tapX <= rect.right &&
        rect.top <= tapY &&
        tapY <= rect.bottom &&
        tapImageFunc != null) {
      tapImageFunc!();
    }
  }

  /*

  // 円のタップ
  void onTapCircle(double scale, double moveX, Offset tapLoc, BuildContext context){
    var tapX = tapLoc.dx;
    var tapY = tapLoc.dy;

    // canvas.drawCircle(Offset(item.position.dx * scale - _getMoveX(),
    //     item.position.dy * scale), 10, paint);
    final offset = Offset(this.position.dx * scale -moveX, this.position.dy * scale);
    final circlex = offset.dx; // offset.dx,dyはそれぞれの2次元座標
    final circley = offset.dy;

    final A = circlex - tapX;
    final B = circley - tapY;
    // 二点間距離
    final dist = math.sqrt(math.pow(A, 2) + math.pow(B, 2));

    if(dist <= 20){
      ModalWindow(context).messe;
    }
    print("距離: " + dist.toString());
    print("tapX" + tapX.toString());
    print("tapY" + tapY.toString());
    print("circleX" + circlex.toString());
    print("circley" + circley.toString());


  }
  */

}

/// マップページのステートフルウィジェット
class MapPage extends StatefulWidget {
  /// コンストラクタ
  MapPage({Key? key, required this.title}) : super(key: key);

  final String title;

  /// ページタイトル

  /// 描画
  @override
  _MapPageState createState() => _MapPageState();
}

/// マップのステート
class _MapPageState extends State<MapPage> {
  ui.Image? _mapImage;

  /// マップの画像
  double _moveX = 0;

  /// x軸の移動を保持
  ///

  MapPainter? _mapPainter = null;

  /// マップの場所情報の一覧
  final _mapItems = <MapItem>[
    MapItem('湯涌稲荷神社', 36.4859822, 136.7560359, Offset(1254, 292),
        'assets/images/img1_gray.png', Rect.fromLTWH(650, 182, 300, 300)),
    MapItem('総湯', 36.4857904, 136.7575357, Offset(1358, 408),
        'assets/images/img2_gray.png', Rect.fromLTWH(820, 820, 300, 300)),
  ];

  /// アセット(画像等)の取得
  void _getAssets() async {
    final ui.Image img = await loadUiImage('assets/images/map_img.png');
    this._mapPainter = MapPainter(img, _getMoveX, _mapItems);
    for (var item in _mapItems) {
      await item.loadInitialImage();
    }
    setState(() => {
      _mapImage = img
    });
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

  /// 見た目
  @override
  Widget build(BuildContext context) {

    final Size mediaSize = MediaQuery.of(context).size; // 画面の取得

    final AppBar appBar = AppBar(title: Text(widget.title,style: TextStyle(color: prefix.Colors.black87))); // ヘッダ部分のUIパーツ
    final mediaHeight = mediaSize.height - appBar.preferredSize.height; // キャンバス部分の高さ

    if ( _mapImage != null ) {
      this._mapPainter = MapPainter(_mapImage!, _getMoveX, _mapItems);
    }

    // 画面遷移用の初期化
    _mapItems.forEach((e) {
      // タップ時に遷移(引数としてMapItemを送る)
      e.tapImageFunc =
          () => Navigator.of(context).pushNamed('/camera_page', arguments: e);
    });

    // UI部分
    return Scaffold(
      appBar: appBar,

      body: Stack(
        children: <Widget>[
          _mapImage == null
              ? // マップ画像の読み込みがない場合はTextを表示
              Text('Loading...')
              : // 画像ロード中の際の表示
              GestureDetector(
                  onTapUp: (details) {
                    // タップ時の処理
                    // 高さを基準にした画像の座標系からデバイスへの座標系への変換倍率
                    for (var item in _mapItems) {
                      // 場所ごとの処理
                      // FIXME: 画像の当たり判定がややy軸方向にズレている(広がっている)
                      // タップの判定処理(タップ時は遷移)
                      item.onTapImage(this._mapPainter!.scale, _getMoveX(), details.localPosition);
                      // item.onTapCircle(scale, _getMoveX(), details.localPosition, context);
                    }
                  },
                  onPanUpdate: (DragUpdateDetails details) {
                    // スクロール時の処理
                    setState(() {
                      // スクロールを適用した場合の遷移先X
                      final next = _moveX - details.delta.dx;
                      // 高さを基準にした画像の座標系からデバイスへの座標系への変換倍率
                      // スクロールできない場所などを考慮した補正をかけてメンバ変数に代入
                      _moveX = min(max(next, 0), _mapImage!.width * this._mapPainter!.scale - mediaSize.width);
                    });
                  },
                  child: CustomPaint(
                    // キャンバス本体
                    size: Size(mediaSize.width, mediaHeight), // サイズの設定(必須)
                    painter: this._mapPainter!, // ペインター
                    child: Center(), // あったほうがいいらしい？？
                  ),
                ),
          SnackBerPage(),
        ],
      ),
    );
  }
}

// ヒント内容
const explainList = ['test', 'testtesttesttesttesttesttest'];
int change = 0;
// 表示するヒントの変数

class SnackBerPage extends StatefulWidget {
  SnackBerPage() : super();


  @override
  _SnackBarPageState createState() => _SnackBarPageState(durationSecond: 3);
}

class _SnackBarPageState extends State<SnackBerPage> {
  final int durationSecond;
  _SnackBarPageState({required this.durationSecond});

  @override
  void initState() {
    Timer.periodic(Duration(seconds: durationSecond), _onTimer);
    super.initState();
  }

  void _onTimer(Timer timer) {
    final random = math.Random();
    final randomNum = random.nextInt(explainList.length);
    setState(() {
      // 表示するヒントを決める変数にランダムに数字を代入
      change = randomNum;
    });
  }

  @override
  Widget build(BuildContext context) {
    final widthsize = MediaQuery.of(context).size.width;
    final heightsize = MediaQuery.of(context).size.height;

    return Container(
      height: widthsize / 6.5,
      margin: EdgeInsets.fromLTRB(heightsize / 8, heightsize / 1.38, 0, 0),
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
            )),
        // 出っ張っている所の指定
        nip: BubbleNip.leftBottom,
      ),
    );
  }
}

@override
Widget build(BuildContext context) {
  return Container();
}
