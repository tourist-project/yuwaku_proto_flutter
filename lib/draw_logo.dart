

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:moor/moor.dart';
import 'dart:ui' as ui;

class DrawLogo {
  Future<Uint8List> execute(GlobalKey widgetGlobalKey) async {
    RenderRepaintBoundary boundary = widgetGlobalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();

    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder);
    final logoImage = await loadLogoImage();

    LogoPainter(image, logoImage)..paint(canvas, Size.infinite);

    final ui.Image renderImage = await recorder.endRecording().toImage(
        image.width,
        image.height + logoImage.height
    );
    ByteData byteData = renderImage.toByteData(format: ui.ImageByteFormat.png) as ByteData;
    return byteData.buffer.asUint8List();
  }

  Future<ui.Image> loadLogoImage() async {
    Completer<ImageInfo> completer = Completer();

    AssetImage('assets/images/text_logo.png').resolve(ImageConfiguration()).addListener(
        (ImageStreamListener((ImageInfo info, bool _) => completer.complete(info))),
    );
    ImageInfo imageInfo = await completer.future;
    return imageInfo.image;
  }
}

class LogoPainter extends CustomPainter {
  final ui.Image picture;
  final ui.Image logo;

  LogoPainter(this.picture, this.logo);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawImage(picture, Offset(20, 20), Paint());
    canvas.drawImage(
        logo,
        Offset(picture.width.toDouble() - logo.width.toDouble(),
            picture.height.toDouble() - logo.height.toDouble()),
        Paint());

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}