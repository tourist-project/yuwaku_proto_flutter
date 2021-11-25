import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:yuwaku_proto/map_page.dart';
import 'distance_between_points.dart';
import 'main.dart';
import 'map_page.dart';
import 'package:geolocator/geolocator.dart';
import 'package:touchable/touchable.dart';

/// マップの描画
class MapPainter extends CustomPainter {


  late ui.Image _mapImage; /// マップ自体の画像
  late double Function() _getMoveX; /// 移動したx軸の距離を返す関数
  late List<MapItem> _mapItems; /// マップ上に描画する場所の一覧
  var scale = 0.0;

  /// コンストラクタ
  MapPainter(ui.Image _mapImage, double Function() _getMoveX, List<MapItem> _mapItems) {
    this._mapImage = _mapImage;
    this._getMoveX = _getMoveX;
    this._mapItems = _mapItems;
  }


  /// 描画
  @override
  void paint(Canvas canvas, Size size) {
    // ペイントの作成
    final paint = Paint()
      ..color = Colors.red // 赤色を設定
      ..strokeWidth = 2; // 線の太さを2に設定

    this.scale = size.height / _mapImage.height.toDouble() ; // 画像を縦方向に引き伸ばした倍率
    final width = size.width / scale ; // 場所を描画している

    final src = Rect.fromLTWH(_getMoveX()/scale, 0, width, _mapImage.height.toDouble()); // 画像中の用いる範囲
    final dst = Rect.fromLTWH(0, 0, size.width, size.height); // 描画場所
    canvas.drawImageRect(_mapImage, src, dst, paint); // 背景マップの描画

    // 場所ごとの処理
    for (var item in _mapItems) {
      // 表示する画像の取得
      final img = item.getDisplayImage();
      // もし画像がロードできていないなら何もしない
      if (img != null) {
        final length = min(img.height, img.width).toDouble(); // 縦横のうち最短を取得
        final ox = (img.width.toDouble() - length)/2;
        final oy = (img.height.toDouble() - length)/2;
        final src = Rect.fromLTWH(ox, oy, length, length); // 画像中の描画する場所を選択
        final rescaleRect = item.getPhotoRectForDeviceFit(scale, _getMoveX()); // どこに描画するかを設定

        Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best).then( (pos) => {
          item.setDistance(pos)
        });
        item.distance = 15;


        if (item.isProximity(30)) {
          paint.color = Color.fromARGB(255, 255, 0, 0);
          // 円を書く
          canvas.drawCircle(Offset(item.position.dx * scale - _getMoveX(), item.position.dy * scale), 10, paint);

          // 線をひく
          canvas.drawLine(Offset((item.photoRect.left * scale - _getMoveX()) + item.photoRect.width * scale / 2,
                                 (item.photoRect.top * scale) + item.photoRect.height * scale / 2),
                          Offset((item.position.dx * scale - _getMoveX()),
                                 item.position.dy * scale), paint);
          canvas.drawImageRect(img, src, rescaleRect, paint);
          // 範囲内だと青くなる
          paint.color = Color.fromARGB(100, 0, 0, 255);
          canvas.drawRect(rescaleRect, paint);
        } else {
          canvas.drawImageRect(img, src, rescaleRect, paint);
          // 範囲外だと赤くなる
          paint.color = Color.fromARGB(100, 255, 0, 0);
          canvas.drawRect(rescaleRect, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }


}


