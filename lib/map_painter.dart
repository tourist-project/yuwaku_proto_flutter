import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:yuwaku_proto/map_page.dart';
import 'map_page.dart';
import 'package:geolocator/geolocator.dart';


/// マップの描画
class MapPainter extends CustomPainter {

  double YInari = 10000000000000;
  double Souyu = 10000000000000;
  double Himuro = 1000000000000;

  final ui.Image _mapImage; /// マップ自体の画像
  final double Function() _getMoveX; /// 移動したx軸の距離を返す関数
  List<MapItem> _mapItems; /// マップ上に描画する場所の一覧
  var scale = 0.0;



  /// コンストラクタ
  MapPainter(this._mapImage, this._getMoveX, this._mapItems);

  /// 描画
  @override
  void paint(Canvas canvas, Size size) async{
    // ペイントの作成
    final paint = Paint()
      ..color = Colors.red // 赤色を設定
      ..strokeWidth = 2; // 線の太さを2に設定

    this.scale = size.height / _mapImage.height.toDouble() ; // 画像を縦方向に引き伸ばした倍率
    final width = size.width / scale ; // 場所を描画している

    final src = Rect.fromLTWH(_getMoveX()/scale, 0, width, _mapImage.height.toDouble()); // 画像中の用いる範囲
    final dst = Rect.fromLTWH(0, 0, size.width, size.height); // 描画場所
    canvas.drawImageRect(_mapImage, src, dst, paint); // 背景マップの描画

    // getLocationInformation();


    // 場所ごとの処理
    for (var item in _mapItems) {
      // 表示する画像の取得
      final img = item.getDisplayImage();

      if(img == null) {
        // 画像がロードできていないなら何もしない
        continue;
      }

      /// 円を書く
      canvas.drawCircle(Offset(item.position.dx * scale - _getMoveX(), item.position.dy * scale), 10, paint);

      /// 現在地とスポットの距離を計測する
      // Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation).then((currentLocation) {
      //   YInari = Geolocator.distanceBetween(currentLocation.latitude, currentLocation.longitude, 36.4856770, 136.7582343);
      //   Souyu = Geolocator.distanceBetween(currentLocation.latitude, currentLocation.longitude, 36.48567221199191, 136.75751246063845);
      // });

      getLocationInformation().then((currentLocation) {
        YInari = Geolocator.distanceBetween(currentLocation.latitude, currentLocation.longitude, 36.4856770, 136.7582343);
        Souyu = Geolocator.distanceBetween(currentLocation.latitude, currentLocation.longitude, 36.48567221199191, 136.75751246063845);
      }).catchError((e) => print(e));


      final length = min(img.height, img.width).toDouble(); // 縦横のうち最短を取得
      // FIXME: 画像を中央に寄せる
      final src = Rect.fromLTWH(0, 0, length, length); // 画像中の描画する場所を選択
      final rescaleRect = item.getPhotoRectForDeviceFit(scale, _getMoveX()); // どこに描画するかを設定
      /// 写真(イラストを表示)
      canvas.drawImageRect(img, src, rescaleRect, paint);

      if (YInari < 30 && item.name == "湯涌稲荷神社") {
        print("==================================================");
        print(YInari);

        // 線をひく
        canvas.drawLine(Offset((item.photoRect.left * scale - _getMoveX()) +
            item.photoRect.width * scale / 2,
            (item.photoRect.top * scale) +
                item.photoRect.height * scale / 2),

            Offset((item.position.dx * scale - _getMoveX()),
                item.position.dy * scale), paint);
      }
      if (Souyu < 30 && item.name == "総湯") {
        print("==================================================");
        print(YInari);

        // 線をひく
        canvas.drawLine(Offset((item.photoRect.left * scale - _getMoveX()) +
            item.photoRect.width * scale / 2,
            (item.photoRect.top * scale) +
                item.photoRect.height * scale / 2),

            Offset((item.position.dx * scale - _getMoveX()),
                item.position.dy * scale), paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }


  static Future<void> openAppSettings() async {
    /// 設定画面に遷移
    await Geolocator.openAppSettings();
  }

  static Future<Position> getLocationInformation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // デバイスの位置情報 On/Off を取得
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      // デバイスの位置情報がOff
      return Future.error('Location services are disabled.');
    }

    // アプリにデバイスの位置情報へのアクセス許可の確認
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // デバイスの場所にアクセスするための許可を要求
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // 初期状態　権限を要求可能
        return Future.error('Location permissions are denied');
      }
    }

    // 設定から変更するまで、アクセス許可を永遠に拒否
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
  }
}


