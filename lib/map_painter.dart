import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:yuwaku_proto/map_page.dart';
import 'main.dart';
import 'map_page.dart';
import 'package:geolocator/geolocator.dart';
import 'package:touchable/touchable.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';

/// マップの描画
class MapPainter extends CustomPainter {

  late ui.Image _mapImage; /// マップ自体の画像
  late ui.Image _cameraIconImg;
  late double Function() _getMoveX; /// 移動したx軸の距離を返す関数
  late List<MapItem> _mapItems; /// マップ上に描画する場所の一覧
  var scale = 0.0;

  /// コンストラクタ
  MapPainter(ui.Image _mapImage, ui.Image _cameraIconImg,
      double Function() _getMoveX, List<MapItem> _mapItems) {
    this._mapImage = _mapImage;
    this._cameraIconImg = _cameraIconImg;
    this._getMoveX = _getMoveX;
    this._mapItems = _mapItems;
  }


  /// 描画
  @override
  void paint(Canvas canvas, Size size) {
    // ペイントの作成
    final mapPaint = Paint();

    this.scale = size.height / _mapImage.height.toDouble(); // 画像を縦方向に引き伸ばした倍率
    final width = size.width / scale; // 場所を描画している

    final src = Rect.fromLTWH(_getMoveX() / scale, 0, width,
        _mapImage.height.toDouble()); // 画像中の用いる範囲
    final dst = Rect.fromLTWH(0, 0, size.width, size.height); // 描画場所
    canvas.drawImageRect(_mapImage, src, dst, mapPaint); // 背景マップの描画

    // 場所ごとの処理
    for (var item in _mapItems) {
      final imagePaint = Paint();
      final circlePaint = Paint();
      final linePaint = Paint()..strokeWidth = 2; // 線の太さを2に設定
      // 表示する画像の取得
      final img = item.getDisplayImage();

      // もし画像がロードできていないなら何もしない
      if (img != null) {
        final length = min(img.height, img.width).toDouble(); // 縦横のうち最短を取得
        final ox = (img.width.toDouble() - length) / 2;
        final oy = (img.height.toDouble() - length) / 2;
        final src = Rect.fromLTWH(ox, oy, length, length); // 画像中の描画する場所を選択


        final movex = _getMoveX();
        final rescaleRect = item.getPhotoRectForDeviceFit(scale, movex); // どこに描画するかを設定
        final scaleDev2 = scale / 2;
        
        /// !!!:debug時はコメント外す
        item.distance = 15;
      
        if (item.isProximity(30)) {
          final xscale = item.position.dx * scale - movex;
          final yscale = item.position.dy * scale;
          final leftscale = item.photoRect.left * scale - movex;
          final topscale = item.photoRect.top * scale;

          circlePaint.color = const Color.fromARGB(255, 255, 0, 0);
          // 円を書く

          canvas.drawCircle(Offset(xscale, yscale), 10, circlePaint);

          // 線をひく
          linePaint.color = const Color.fromARGB(255, 255, 0, 0);
          canvas.drawLine(Offset(leftscale + item.photoRect.width * scaleDev2,
                                 topscale + item.photoRect.height * scaleDev2),
                          Offset(xscale, yscale), linePaint);
          canvas.drawImageRect(img, src, rescaleRect, imagePaint);
          canvas.drawImageRect(_cameraIconImg, const Rect.fromLTWH(0, 0, 256, 256),
                               Rect.fromLTWH(leftscale + 5, topscale + 5, 50, 50), imagePaint);

        } else {
          canvas.drawImageRect(img, src, rescaleRect, imagePaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  /// 位置情報を取得（不可の場合、どうしてダメなのかを返す）
  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }


    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

  }

}
