import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
          minScale: 0.1,
          maxScale: 2.0,
          child: Image.asset('assets/images/YuwakuMap.png'),
        ),
      ),


    );

  }
}
