import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
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
import 'package:flutter/material.dart' as prefix;
import 'package:bubble/bubble.dart';
import 'map_painter.dart';// Colorsを使う時はprefix.Colors.~と使ってください


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
  ui.Rect photoRect;/// 画像の四角
  ui.Image? initialImage;
  void Function()? tapImageFunc; /// タップ時に動く関数
  final imageDb = ImageDBProvider.instance;/// 初期化時のイラスト
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
    if (rect.left <= tapX && tapX <= rect.right &&
        rect.top <= tapY && tapY <= rect.bottom && tapImageFunc != null) {
      tapImageFunc!();
    }
  }
}

/// マップページのステートフルウィジェット
class MapPage extends StatefulWidget {
  /// コンストラクタ
  MapPage({Key? key, required this.title}) : super(key: key);
  final String title;/// ページタイトル

  /// 描画
  @override
  _MapPageState createState() => _MapPageState();
}

/// マップのステート
class _MapPageState extends State<MapPage> {

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
    final double mediaHeight = mediaSize.height - appBar.preferredSize.height; // キャンバス部分の高さ

    if ( _mapImage != null ) {
      this._mapPainter = MapPainter(_mapImage!, _getMoveX, _mapItems);
    }

    // 画面遷移用の初期化
    _mapItems.forEach((e) {
      // タップ時に遷移(引数としてMapItemを送る)
      e.tapImageFunc =
          () => Navigator.of(context).pushNamed('/camera_page', arguments: e);
    });

    return Scaffold(
      appBar: appBar,
      body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            GestureDetector(
              onTapUp: (details) {// タップ時の処理
                // 高さを基準にした画像の座標系からデバイスへの座標系への変換倍率
                for (var item in _mapItems) {
                  // 場所ごとのタップの判定処理(タップ時は遷移)
                  item.onTapImage(this._mapPainter!.scale, _getMoveX(), details.localPosition);
                }
              },
              onPanUpdate: (DragUpdateDetails details) {// スクロール時の処理
                /* 位置情報が
                - 許可 : マップのスクロール処理
                - 拒否 : AlertDialog(Android) or CupertinoAlertDialog(iOS)で使用許可を求める
               */
                MapPainter.getLocationInformation().then((value) {
                  // 位置情報が許可されている
                  setState(() {
                    // スクロールを適用した場合の遷移先X
                    final next = _moveX - details.delta.dx;
                    // 高さを基準にした画像の座標系からデバイスへの座標系への変換倍率
                    // スクロールできない場所などを考慮した補正をかけてメンバ変数に代入
                    _moveX = min(max(next, 0), _mapImage!.width * this._mapPainter!.scale - mediaSize.width);
                  });
                }).catchError((error) {
                  // 位置情報が拒否されている
                  _dialogLocationLicense();
                });

              },
              child: CustomPaint(
                // キャンバス本体
                size: Size(mediaSize.width, mediaHeight), // サイズの設定(必須)
                painter: this._mapPainter, // ペインター
                child: Center(), // あったほうがいいらしい？？
              ),
            ),
            SnackBerPage()
          ]
      ),
    );
  }

  /// 位置情報が拒否されている時、「位置情報を許可する」ダイアログを表示する
  Future<void> _dialogLocationLicense() async {
    var result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        if(Platform.isAndroid) {
          return AlertDialog(
            title: Text('位置情報を許可する'),
            content: Text('設定でアプリに位置情報を許可します。'),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel'),
                onPressed: () => Navigator.of(context).pop(false),
              ),
              TextButton(
                child: Text('OK'),
                onPressed: () => Navigator.of(context).pop(true),
              ),
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
              onPressed: () => Navigator.of(context).pop(false),
            ),
            CupertinoDialogAction(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );

    // unwrap
    if(result == null) {
      return;
    }

    if(result) {
      MapPainter.openAppSettings();
    }
  }
}



// ヒント内容
const explainList = ['森に囲まれた長い段差を乗り越えるとそこには', '川にかかった大きな橋、森を見守るような厳かな表情'];
int change = 0;
// 表示するヒントの変数

class SnackBerPage extends StatefulWidget {
  SnackBerPage() : super();

  @override
  _SnackBarPageState createState() => _SnackBarPageState(durationSecond: 10);
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

    if(mounted){
      setState(() {
        // 表示するヒントを決める変数にランダムに数字を代入
        change = randomNum;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final widthsize = MediaQuery.of(context).size.width;
    final heightsize = MediaQuery.of(context).size.height;

    return Container(
      height: widthsize / 6,
      margin: EdgeInsets.fromLTRB(heightsize / 8, heightsize / 1.5, 0, 0),
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
    );
  }
}

@override
Widget build(BuildContext context) {

  return Container();
}



/// This is the stateless widget that the main application instantiates.
class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('AlertDialog Title'),
          content: const Text('AlertDialog description'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      ),
      child: const Text('Show Dialog'),
    );
  }
}
