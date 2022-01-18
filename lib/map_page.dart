import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';
import 'package:yuwaku_proto/database.dart';
import 'package:flutter/material.dart' as prefix;
import 'package:bubble/bubble.dart';
import 'camera_page.dart';
import 'package:geolocator/geolocator.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'map_item.dart';
import 'location.dart';

final mapItemListProvider = StateNotifierProvider<MapItemList, List<MapItem>>((ref) {
  /// TODO: DBにデータがある場合、if文でpath入れ用のreturnを追記
  return MapItemList([
    MapItem(name: '総湯', latitude: 36.485425901995455, longitude: 136.75758738535384, position: Offset(1358, 408),
        initialImagePath: 'assets/images/img2_gray.png', photoRect: Rect.fromLTWH(1000, 820, 280, 280)),
    MapItem(name: '氷室', latitude: 36.48346516395541, longitude: 136.75701193508996, position: Offset(1881, 512),
        initialImagePath: 'assets/images/himurogoya_gray.png', photoRect: Rect.fromLTWH(1720, 620, 280, 280)),
    MapItem(name: '足湯(立派な方)', latitude: 36.48582537854954, longitude: 136.7574341842218, position: Offset(1275, 385),
        initialImagePath: 'assets/images/asiyu(temp)_gray.png', photoRect: Rect.fromLTWH(1500, 60, 280, 280)),
    MapItem(name: '湯涌夢二館', latitude: 36.48584951599308, longitude: 136.75738876226737, position: Offset(1250, 425),
        initialImagePath: 'assets/images/yumejikan_gray.png', photoRect: Rect.fromLTWH(580, 80, 280, 280)),
  ]);
});

final indexedSelectorProvider = StateProvider((ref) => 0);
/* 位置情報用に残している
return GestureDetector(
          onTapUp: (details) { // タップ時の処理
            // 高さを基準にした画像の座標系からデバイスへの座標系への変換倍率
            for (var item in _mapItems) {
              // TODO: 実際に現地で検証して
              if (item.isProximity(30)) {
                // 場所ごとのタップの判定処理(タップ時は遷移)
                if (item.didTappedImageTransition(this._mapPainter!.scale, _getMoveX(), details.localPosition)) {

                  Navigator.of(context).pushNamed('/camera_page', arguments: item);
                  break;
                }
              }
            }
          },

             // Stack(
          //   children: [
          //     pageClear!,
          //     ElevatedButton(
          //       onPressed: () {
          //         imageDb.deleteAll();
          //         for (var item in _mapItems) {
          //           item.photoImage = null;
          //         }
          //       },
          //       child: const Text('もう一度'),
          //     ),
          //   ],
          // ),

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
 */

class MapPageState extends ConsumerWidget {
  final imageDb = ImageDBProvider.instance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapImageHeight = MediaQuery.of(context).size.height - kToolbarHeight - kBottomNavigationBarHeight - kTextTabBarHeight;

    final spot = ref.watch(mapItemListProvider);
    final index = ref.watch(indexedSelectorProvider.state).state;

    // 位置情報が更新されたら処理される
    ref.watch(locationProvider.stream).listen((location) {
      for(final check in spot) {
        // 現在地とスポットの距離をメートル単位で測る
        final measure = Geolocator.distanceBetween(location.latitude, location.longitude, check.latitude, check.longitude);

        ref.read(mapItemListProvider.notifier).updatePositionalRelation(name: check.name, distance: measure);
      }
    });

    return Scaffold(
      appBar: AppBar(title: Text('地図', style: TextStyle(color: prefix.Colors.black87))),
      body: IndexedStack(
        index: index,
        children: [
          InteractiveViewer(
            constrained: false,
            scaleEnabled: false,
            child: Stack(
              children: <Widget>[
                Image.asset('assets/images/map_img.png', fit: BoxFit.cover, height: mapImageHeight),
                Positioned(
                  top: 50,
                  left: 200,
                  child: OutlinedButton(
                    onPressed: !spot.first.tap ? null : () => seguePageSwitcher(context, ref, 0),
                    child: Image.asset(spot.first.initialImagePath, width: 200, height: 100, fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  top: 50,
                  right: 200,
                  child: OutlinedButton(
                    onPressed: !spot[1].tap ? null :() => seguePageSwitcher(context, ref, 1),
                    child: Image.asset(spot[1].initialImagePath, width: 200, height: 100, fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  bottom: 50,
                  left: 200,
                  child: OutlinedButton(
                    onPressed: !spot[2].tap ? null : () => seguePageSwitcher(context, ref, 2),
                    child: Image.asset(spot[2].initialImagePath, width: 200, height: 100, fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  bottom: 50,
                  right: 200,
                  child: OutlinedButton(
                    onPressed: !spot[3].tap ? null : () => seguePageSwitcher(context, ref, 3),
                    child: Image.asset(spot[3].initialImagePath, width: 200, height: 100, fit: BoxFit.cover),
                  ),
                ),
              ],
            ),
          ),
          Center(child: Text('OK')),
        ],
      )
    );
  }

  void seguePageSwitcher(BuildContext ctx, WidgetRef ref, int num) {
    final item = ref.read(mapItemListProvider.notifier).state[num];
    print(item.tap);

    Navigator.push(ctx, MaterialPageRoute(builder: (context) => CameraPageState(item, num)))
        .then((_) {
      // 撮影数のカウント
      final numOfShots = ref.read(mapItemListProvider).where((element) => element.initialImagePath.length > 50).length;
      // 全て撮影されたら、クリア画面に遷移
      if(numOfShots == ref.read(mapItemListProvider).length) ref.read(indexedSelectorProvider.notifier).state = 1;
    }).catchError((error) {
      print('seguePageSwitcher'+'$error');
    });
  }

  /// 位置情報が拒否されている時、「位置情報を許可する」ダイアログを表示する
  Future<void> _dialogLocationLicense(BuildContext ctx) async {
    var result = await showDialog<bool>(
      context: ctx,
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
