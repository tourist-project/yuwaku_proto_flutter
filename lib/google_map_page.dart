import 'dart:async';
import 'package:flutter/material.dart';
import 'main.dart';

class GoogleMapPage extends StatefulWidget{
  GoogleMapPage({Key? key, required this.title}): super(key: key);

  _GoogleMapPage createState() => _GoogleMapPage();
  final String title;
}

class _GoogleMapPage extends State<GoogleMapPage>{

  String _title = 'MapPage';


  @override
  Widget build(BuildContext context) {

    double mediaWidth = MediaQuery.of(context).size.width;
    double mediaHeight = MediaQuery.of(context).size.height;
    double appBarHeight = AppBar().preferredSize.height;

    double screenHeight = mediaHeight - appBarHeight;



    return new Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: Container(
        height: screenHeight,
        width: mediaWidth,

        child: Column(
          children: [
            Container(
              height: screenHeight / 2,
              color: Colors.red,
            ),


            SizedBox(
              height: screenHeight / 3,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Card(
                    child: Container(
                      width: 200,
                    ),
                    color: Colors.blue,
                  ),
                  Card(
                    child: Container(
                      width: 200,
                    ),
                    color: Colors.green,
                  ),
                  Card(
                    child: Container(
                      width: 200,
                    ),
                    color: Colors.yellow,
                  ),
                  Card(
                    child: Container(
                      width: 200,
                    ),
                    color: Colors.pink,
                  ),
                ],
                shrinkWrap: true,
              ),
            ),
          ],
        ),

      ),

    );
  }

}