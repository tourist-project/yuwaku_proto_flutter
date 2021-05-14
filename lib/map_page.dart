import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:ui' as ui;
import 'package:yuwaku_proto/map_painter.dart';

class MapPage extends StatefulWidget {
  MapPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  ui.Image? _mapImage;
  double _moveX = 0;

  Future<ui.Image> loadUiImage(String imageAssetPath) async {
    final ByteData data = await rootBundle.load(imageAssetPath);
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(Uint8List.view(data.buffer), (ui.Image img) {
      return completer.complete(img);
    });
    return completer.future;
  }

  void _getAssets() async {
    final ui.Image img = await loadUiImage('assets/images/map_img.png');
    setState(() => { _mapImage = img });
  }

  double _getMoveX() {
    return _moveX;
  }

  @override
  void initState() {
    super.initState() ;
    _getAssets();
  }

  @override
  Widget build(BuildContext context) {
    final Size mediaSize = MediaQuery.of(context).size;
    final AppBar appBar = AppBar(title: Text(widget.title) );

    return Scaffold(
      appBar: appBar,
      body: Center(
        child: _mapImage == null ?
          Text('Loading...') :
          GestureDetector(
            onPanUpdate: (DragUpdateDetails details) {
              setState(() {
                if (_mapImage != null) {
                  final next = _moveX - details.delta.dx;
                  final scale = mediaSize.height / _mapImage!.height.toDouble() ;
                  debugPrint((scale).toString());
                  _moveX = min(max(next, 0), _mapImage!.width*scale-mediaSize.width/scale);
                  debugPrint(_moveX.toString());
                }
              });
            },
            child: CustomPaint(
              size: Size(mediaSize.width, mediaSize.height - appBar.preferredSize.height),
              painter: MapPainter(_mapImage!, _getMoveX),
              child: Center(),
            ),
          )
      ),
    );
  }
}