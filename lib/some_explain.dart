import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;
import 'package:simple_animations/simple_animations.dart';

class Explain extends StatelessWidget{

  Explain({Key? key, required this.title}) : super(key: key);
  final String title; /// ページタイトル

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: FractionalOffset.topLeft,
            end: FractionalOffset.bottomRight,
            colors: [
              const Color(0xffe4a972).withOpacity(0.6),
              const Color(0xff9941d8).withOpacity(0.6),
            ],
            stops: const [0.0, 1.0,],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: Container(
                  child: Image.network(
                    'https://www.10wallpaper.com/wallpaper/1366x768/2005/Mountains_Rocks_Lake_2020_Landscape_High_Quality_Photo_1366x768.jpg',
                  ),
                ),
              ),
              Container(
                height: 200,
                
              ),
            ],
          ),


        ),
      ),
    );
  }
}

