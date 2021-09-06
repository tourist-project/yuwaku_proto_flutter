import 'package:flutter/material.dart';
import 'package:yuwaku_proto/map_page.dart';
import 'package:yuwaku_proto/camera_page.dart';
import 'package:yuwaku_proto/Distance_twoPosition.dart';
import 'package:yuwaku_proto/map_painter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:yuwaku_proto/some_explain.dart';


void main() {
  runApp(MyApp());

}

class MyApp extends StatelessWidget {



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MapPage(title: 'Map page'),
      routes: <String, WidgetBuilder> {
        '/map_page': (BuildContext context) => MapPage(title: 'Map page'),
        '/camera_page': (BuildContext context) => CameraPage(title: 'Camera page',
                                                             mapItem: ModalRoute.of(context)!.settings.arguments as MapItem),
        '/some_explain':(BuildContext context) => Explain(title: '場所説明', ),
      },
    );

  }
}

