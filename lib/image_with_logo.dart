import 'dart:typed_data';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yuwaku_proto/draw_logo.dart';

class ImageWithLogo extends StatefulWidget {
  ImageWithLogo({Key? key, required this.picture}) : super(key: key);

  final Image picture;

  @override
  _ImageWithLogoState createState() => _ImageWithLogoState();
}

class _ImageWithLogoState extends State<ImageWithLogo> {
  GlobalKey _globalKey = GlobalKey();
  Uint8List? _imageWithLogo;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: makeImage(),
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return RepaintBoundary(
              key: _globalKey,
              child: SafeArea(
                child: Image.memory(_imageWithLogo!),
              ),
            );
          } else {
            return Text("No Image");
          }
        }
    );
  }

  makeImage() async {
    _imageWithLogo = await DrawLogo().execute(_globalKey);
  }
}
