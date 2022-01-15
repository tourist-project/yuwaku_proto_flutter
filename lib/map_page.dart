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
import 'camera_page.dart';
import 'map_painter.dart';// Colorsを使う時はprefix.Colors.~と使ってください
import 'package:geolocator/geolocator.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'map_item.dart';


final mapItemListProvider = StateNotifierProvider<MapItemList, List<MapItem>>((ref) {
  /// TODO: DBにデータがある場合、if文でpathの入れ用のreturnを追記
  return MapItemList([
    MapItem('総湯', 36.485425901995455,  136.75758738535384, Offset(1358, 408),
        'assets/images/img2_gray.png', Rect.fromLTWH(1000, 820, 280, 280)),
    MapItem('氷室', 36.48346516395541, 136.75701193508996, Offset(1881, 512),
        'assets/images/himurogoya_gray.png', Rect.fromLTWH(1720, 620, 280, 280)),
    MapItem('足湯(立派な方)', 36.48582537854954, 136.7574341842218, Offset(1275, 385),
        'assets/images/asiyu(temp)_gray.png', Rect.fromLTWH(1500, 60, 280, 280)),
    MapItem('湯涌夢二館', 36.48584951599308, 136.75738876226737, Offset(1250, 425),
        'assets/images/yumejikan_gray.png', Rect.fromLTWH(580, 80, 280, 280)),
  ]);
});

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
  // MapPainter? _mapPainter = null;
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
    MapItem('足湯(立派な方)', 36.48582537854954, 136.7574341842218, Offset(1275, 385),
        'assets/images/asiyu(temp)_gray.png', Rect.fromLTWH(1500, 60, 280, 280)),
   /* MapItem('足湯(湯の出)', 36.48919374904115, 136.75588850463596, Offset(505, 690),
        'assets/images/Asiyu(temp).png', Rect.fromLTWH(750, 80, 280, 280)),
        */
    /*MapItem('みどりの里', 36.49050881078798, 136.75404574490975, Offset(239, 928),
        'assets/images/MidorinoSato.png', Rect.fromLTWH(280, 850, 280, 280))*/
    MapItem('湯涌夢二館', 36.48584951599308, 136.75738876226737, Offset(1250, 425),
        'assets/images/yumejikan_gray.png', Rect.fromLTWH(580, 80, 280, 280)),
  ];


  /// アセット(画像等)の取得
  Future<void> _getAssets() async {
    final ui.Image img = await MapItem.loadUiImage('assets/images/map_img.png');
    final ui.Image cameraIconImg = await MapItem.loadUiImage('assets/images/camera_red.png');
    // this._mapPainter = MapPainter(img, cameraIconImg, _getMoveX, _mapItems);
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

  late Future<void> _initializeCheckPointFuture;  // CheckPointの画像を読み込み完了を検知する

  Image sample = Image.asset('assets/images/img2_gray.png', width: 200, fit: BoxFit.fitWidth);

  @override
  void initState() {
    super.initState();
    print('initState');
    // MapPainter.determinePosition().catchError((_) => _dialogLocationLicense());
    _initializeCheckPointFuture = _getAssets();
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

    // if (_mapImage != null) {
    //   this._mapPainter = MapPainter(_mapImage!,_cameraIconImg!, _getMoveX, _mapItems);
    // }

    return Scaffold(
      appBar: appBar,
      body: FutureBuilder<void>(
        future: _initializeCheckPointFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (!this.is_clear) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Consumer(
                  builder: (context, spots, child) {
                    final spot = spots.watch(mapItemListProvider);
                    return Stack(
                      children: <Widget>[
                        Image.asset('assets/images/map_img.png', fit: BoxFit.cover, height: double.infinity,),
                        Positioned(
                            top: 50,
                            left: 200,
                            child: OutlinedButton(
                              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CameraPageState(_mapItems[0], 0))),
                              child: Image.asset(spot.first.initialImagePath, width: 200, height: 100, fit: BoxFit.cover),
                            ),
                        ),
                        Positioned(
                          top: 50,
                          right: 200,
                          child: OutlinedButton(
                            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CameraPageState(_mapItems[1], 1))),
                            child: Image.asset(spot[1].initialImagePath, width: 200, height: 100, fit: BoxFit.cover),
                          ),
                        ),
                        Positioned(
                          bottom: 50,
                          left: 200,
                          child: OutlinedButton(
                            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CameraPageState(_mapItems[2], 2))),
                            child: Image.asset(spot[2].initialImagePath, width: 200, height: 100, fit: BoxFit.cover),
                          ),
                        ),
                        Positioned(
                          bottom: 50,
                          right: 200,
                          child: OutlinedButton(
                            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CameraPageState(_mapItems[3], 3))),
                            child: Image.asset(spot[3].initialImagePath, width: 200, height: 100, fit: BoxFit.cover),
                          ),
                        ),
                      ],
                    );
                  }
                )
              );

              // return GestureDetector(
              //   onTapUp: (details) { // タップ時の処理
              //     // 高さを基準にした画像の座標系からデバイスへの座標系への変換倍率
              //     for (var item in _mapItems) {
              //       // TODO: 実際に現地で検証して
              //       if (item.isProximity(30)) {
              //         // 場所ごとのタップの判定処理(タップ時は遷移)
              //         if (item.didTappedImageTransition(this._mapPainter!.scale, _getMoveX(), details.localPosition)) {
              //
              //           Navigator.of(context).pushNamed('/camera_page', arguments: item);
              //           break;
              //         }
              //       }
              //     }
              //   },
              //   onPanUpdate: (DragUpdateDetails details) { // スクロール時の処理
              //     setState(() {
              //       // スクロールを適用した場合の遷移先X
              //       final next = _moveX - details.delta.dx;
              //       // 高さを基準にした画像の座標系からデバイスへの座標系への変換倍率
              //       // スクロールできない場所などを考慮した補正をかけてメンバ変数に代入
              //       _moveX = min(max(next, 0),
              //           _mapImage!.width * this._mapPainter!.scale -
              //               mediaSize.width);
              //     });
              //   },
              //   child: CustomPaint(
              //     // キャンバス本体
              //     size: Size(mediaSize.width, mediaHeight), // サイズの設定(必須)
              //     painter: this._mapPainter!, // ペインター
              //     child: Center(), // あったほうがいいらしい？？
              //   ),
              // );
            } else {
              if (!is_reset_images && pageClear != null) {
                this.pageClear!.width = mediaSize.width;
                this.pageClear!.height = mediaSize.height;
                this.is_reset_images = true;
              }
              return Stack(
                children: [
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
              );
            }
          } else {
            return Center(child: Text('Loading...', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)));
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
