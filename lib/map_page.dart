import 'dart:math' as math;
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:yuwaku_proto/main.dart';
import 'dart:ui' as ui;
import 'package:yuwaku_proto/map_painter.dart';
import 'Distance_twoPosition.dart';
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
  
  /// 追加される写真

  void Function()? tapImageFunc;

  /// タップ時に動く関数

  /// イニシャライズ
  MapItem(this.name, this.latitude, this.longitude, this.position,
      this.initialImagePath, this.photoRect,
      {tapImageFunc});

  /// 初期画像のロード
  Future loadInitialImage() async {
    initialImage = await loadUiImage(initialImagePath);
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
}

/// 表示するヒントの内容
List<String> word = [
  'Gawr Gura',
  'Mori Colliope',
  'Takanashi Kiara',
  'Ninomae Inanis',
  'Watson Amelia'
];

/// マップページのステートフルウィジェット
class MapPage extends StatefulWidget {
  /// コンストラクタ
  MapPage({Key? key, required this.title}) : super(key: key);

  final String title;

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


  /// マップの場所情報の一覧
  final _mapItems = <MapItem>[
    MapItem('湯涌稲荷神社', 36.4859822, 136.7560359,
            Offset(1254, 292), 'assets/images/img1_gray.png',
            Rect.fromLTWH(650, 182, 300, 300)
    ),

    MapItem('総湯', 36.4857904, 136.7575357,
            Offset(1358, 408), 'assets/images/img2_gray.png',
            Rect.fromLTWH(820, 820, 300, 300)
    ),
  ];

  /// アセット(画像等)の取得
  void _getAssets() async {
    final ui.Image img = await loadUiImage('assets/images/map_img.png');
    for (var item in _mapItems) {
      await item.loadInitialImage();
    }
    setState(() => {_mapImage = img});
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
    final AppBar appBar = AppBar(title: Text(widget.title)); // ヘッダ部分のUIパーツ
    final mediaHeight =
        mediaSize.height - appBar.preferredSize.height; // キャンバス部分の高さ

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
          _mapImage == null ? // マップ画像の読み込みがない場合はTextを表示
          Text('Loading...') : // 画像ロード中の際の表示


          GestureDetector(
            onTapUp: (details) { // タップ時の処理

              // 高さを基準にした画像の座標系からデバイスへの座標系への変換倍率
              final scale = mediaHeight / _mapImage!.height.toDouble();
              for (var item in _mapItems) { // 場所ごとの処理
                // FIXME: 画像の当たり判定がややy軸方向にズレている(広がっている)
                // タップの判定処理(タップ時は遷移)
                item.onTapImage(scale, _getMoveX(), details.localPosition);
              }
            },


            onPanUpdate: (DragUpdateDetails details) { // スクロール時の処理
              setState(() {

                // スクロールを適用した場合の遷移先X
                final next = _moveX - details.delta.dx;
                // 高さを基準にした画像の座標系からデバイスへの座標系への変換倍率
                final scale = mediaHeight / _mapImage!.height.toDouble() ;
                // スクロールできない場所などを考慮した補正をかけてメンバ変数に代入
                _moveX = min(max(next, 0), _mapImage!.width*scale-mediaSize.width/scale);
              });
            },


            child: CustomPaint( // キャンバス本体

              size: Size(mediaSize.width, mediaHeight), // サイズの設定(必須)
              painter: MapPainter(_mapImage!, _getMoveX, _mapItems), // ペインター
              child: Center(), // あったほうがいいらしい？？

            ),
          ),
          SnackberPage(),
          if (hihtrunCheck) _runningHihtbar(),
        ],
      ),
    );

  }
}

// ↓北川担当パート ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ヒントを表示させるかどうかのフラグ
bool hihtrunCheck = true;

// 表示するヒント
String hihtPrint = 'どこどこに向かってみよう';

class _runningHihtbar extends StatefulWidget {
  runningHihtbar createState() => runningHihtbar();
}

// ヒントを表示させるtextの設定や時間管理をするためのクラス
class runningHihtbar extends State<_runningHihtbar> {
  Widget build(BuildContext context) {
    // スマホサイズの代入
    final double deviceSize = MediaQuery.of(context).size.height;

    // ヒントを表示させる秒数を決める
    Timer(const Duration(seconds: 1), stoppinghiht);

    var container = Container(
      alignment: Alignment.bottomCenter,

      // コメント見たくするTextの拡張機能
      child: Bubble(
        // Textの位置を決める
        margin: BubbleEdges.only(top: 20, left: deviceSize * 0.3),
        // 尖ってるところを決める
        nip: BubbleNip.leftTop,

        child: Text(
          hihtPrint,
          style:
              TextStyle(fontSize: deviceSize * 0.025, fontFamily: 'Meiryo UI'),
        ),
      ),
    );
    return container;
  }
}

// ヒント表示をストップして新しいヒントの準備をするクラス
void stoppinghiht() {
  if (hihtrunCheck) {
    hihtrunCheck = false;
    var random = math.Random();
    var randomnum = random.nextInt(word.length);
    hihtPrint = word[randomnum];
    word.remove(word[randomnum]);

    // ヒントを表示させる前のインターバルタイム
    Timer(const Duration(seconds: 1), runninghiht);
  }
}

// ヒントを表示させる関数
void runninghiht() {
  hihtrunCheck = true;
}
