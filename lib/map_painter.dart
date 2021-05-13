import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class MapPainter extends CustomPainter {

  final ui.Image _mapImage;

  MapPainter(this._mapImage) ;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue;

    final scale = _mapImage.height.toDouble() / size.height ;
    final width = _mapImage.width/(_mapImage.width/scale/size.width);

    final src = Rect.fromLTWH(0, 0, width, _mapImage.height.toDouble());
    final dst = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawImageRect(_mapImage, src, dst, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}