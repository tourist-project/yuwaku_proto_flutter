import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;
import 'package:simple_animations/simple_animations.dart';
import 'package:yuwaku_proto/map_page.dart';

class Explain extends StatelessWidget{

  Explain({Key? key, required this.title}): super(key: key);

 final String title;

  @override
  Widget build(BuildContext context) {

    // 各種類の画面サイズ
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;


    return new Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        height: deviceHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: FractionalOffset.topLeft,
            end: FractionalOffset.bottomRight,
            colors: [
              const Color(0xffe4a972).withOpacity(0.6),
              const Color(0xff9941d8).withOpacity(0.6),
            ],
          ),
        ),

        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment(-0.8, 0.5),
                child: Container(
                  width: deviceWidth*0.7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black87,
                          offset: Offset(10.0, 20.0),
                          blurRadius: 10,
                          spreadRadius: 3)
                    ],
                  ),
                  child: Stack(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          'https://www.10wallpaper.com/wallpaper/1366x768/2005/Mountains_Rocks_Lake_2020_Landscape_High_Quality_Photo_1366x768.jpg',
                        ),
                      ),

                      Text('第一ステージ',
                          style:TextStyle(fontSize: 40,fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,)
                      ),
                    ],
                  ),
                ),
              ),



              Align(
                alignment: Alignment(0.5, -0.5),

                child: Container(
                  width: deviceWidth*0.7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black87,
                          offset: Offset(10.0, 20.0),
                          blurRadius: 10,
                          spreadRadius: 3)
                    ],
                  ),
                  child: Stack(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          'https://www.10wallpaper.com/wallpaper/1366x768/2005/Mountains_Rocks_Lake_2020_Landscape_High_Quality_Photo_1366x768.jpg',
                        ),
                      ),
                      Text('第二ステージ',
                          style:TextStyle(fontSize: 40,fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,)
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),

        ),
      ),
    );
  }
}

