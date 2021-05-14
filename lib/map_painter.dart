import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class MapPainter extends CustomPainter {

  final ui.Image _mapImage;
  final double Function() _getMoveX;

  // 1254, 292 湯涌稲荷神社
  // 1358, 408 総湯

  MapPainter(this._mapImage, this._getMoveX) ;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue;
    final scale = size.height / _mapImage.height.toDouble() ;
    final width = _mapImage.width/(_mapImage.width*scale/size.width);
    final src = Rect.fromLTWH(_getMoveX(), 0, width, _mapImage.height.toDouble());
    final dst = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawImageRect(_mapImage, src, dst, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}