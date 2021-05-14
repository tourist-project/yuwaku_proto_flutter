import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:yuwaku_proto/map_page.dart';

/// マップの描画
class MapPainter extends CustomPainter {

  final ui.Image _mapImage; /// マップ自体の画像
  final double Function() _getMoveX; /// 移動したx軸の距離を返す関数
  List<MapItem> _mapItems; /// マップ上に描画する場所の一覧

  /// コンストラクタ
  MapPainter(this._mapImage, this._getMoveX, this._mapItems) ;

  /// 描画
  @override
  void paint(Canvas canvas, Size size) {

    // ペイントの作成
    final paint = Paint()
      ..color = Colors.red // 赤色を設定
      ..strokeWidth = 2; // 線の太さを2に設定

    final scale = size.height / _mapImage.height.toDouble(); // 画像を縦方向に引き伸ばした倍率
    final width = _mapImage.width/(_mapImage.width*scale/size.width); // 一度に描画できる横幅

    final src = Rect.fromLTWH(_getMoveX()/scale, 0, width, _mapImage.height.toDouble()); // 画像中の用いる範囲
    final dst = Rect.fromLTWH(0, 0, size.width, size.height); // 描画場所
    canvas.drawImageRect(_mapImage, src, dst, paint); // マップの描画

    // 場所ごとの処理
    for (var item in _mapItems) {

      // 表示する画像の取得
      final img = item.getDisplayImage();

      // もし画像がロードできていないなら何もしない
      if (img != null) {
        final length = min(img.height, img.width).toDouble(); // 縦横のうち最短を取得
        // FIXME: 画像を中央に寄せる
        final src = Rect.fromLTWH(0, 0, length, length); // 画像中の描画する場所を選択
        final rescaleRect = item.getPhotoRectForDeviceFit(scale, _getMoveX()); // どこに描画するかを設定

        // 線をひく
        canvas.drawLine(Offset((item.photoRect.left*scale-_getMoveX())+item.photoRect.width*scale/2,
                                (item.photoRect.top*scale)+item.photoRect.height*scale/2),
                        Offset((item.position.dx * scale - _getMoveX()), item.position.dy * scale), paint);

        // 円を書く
        canvas.drawCircle(Offset(item.position.dx * scale - _getMoveX(),
                                 item.position.dy * scale), 10, paint);

        // 写真(イラストを表示)
        canvas.drawImageRect(img, src, rescaleRect, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}