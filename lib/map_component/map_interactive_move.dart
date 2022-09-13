import 'dart:convert';
import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:yuwaku_proto/map_component/map_page.dart';


class InteractiveMap extends StatefulWidget{

  InteractiveMap({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _InteractiveMap createState() => _InteractiveMap();
}


class _InteractiveMap extends State<InteractiveMap>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black54,
        ),
        child: InteractiveViewer(
          boundaryMargin: const EdgeInsets.all(30.0),
          constrained: false,
          scaleEnabled: true,
          minScale: 0.2,
          maxScale: 2.0,
          child: Image.asset('assets/images/map_img.png'),
        ),
      ),


    );

  }
}
