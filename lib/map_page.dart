import 'package:flutter/material.dart';

class MapPage extends StatefulWidget {
  MapPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text('Map page!'),

            TextButton(
              onPressed: () => Navigator.of(context).pushNamed('/camera_page'),
              child: Text('goto camera!'),
            )
          ],
        ),
      ),
    );
  }
}