import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:vector_math/vector_math.dart';
import 'package:yuwaku_proto/main.dart';
import 'dart:ui' as ui;
import 'package:yuwaku_proto/map_painter.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart' as prefix;
import 'package:bubble/bubble.dart';
import 'map_painter.dart';// Colorsを使う時はprefix.Colors.~と使ってください


class topPageView extends StatelessWidget{

  final String name = "撮っテク!";

  @override
  Widget build(BuildContext context) {
    final mediaHeight = MediaQuery.of(context).size.height; // 画面の取得
    final mediaWidth = MediaQuery.of(context).size.width;
    return Scaffold(

      appBar: AppBar(
        title: Text(name,
            style: TextStyle(color: prefix.Colors.black),
          ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(249,234,205,50),
      ),

      body: Container(
        decoration: const BoxDecoration( // 背景
            image: DecorationImage(
              image: AssetImage('assets/images/TopView.png'),
              fit: BoxFit.cover,
            )
        ),
        height: mediaHeight,
        width: mediaWidth,

        child: Column(
          children: <Widget>[
            Opacity(opacity: 0.6,
              child: Container(
                height: mediaHeight/12,
                width: mediaWidth,
                color: prefix.Colors.black,
                child: SizedBox(
                  width: mediaWidth/2,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Text("2022年1月30日",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: prefix.Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: mediaWidth,
              height: mediaHeight/3,
              color: prefix.Colors.red,
            ),

            Container(
              child: Row(
                children: <Widget>[
                  Spacer(),
                  FloatingActionButton(
                    backgroundColor: prefix.Colors.redAccent,
                    onPressed: () {
                      print("遊び方");
                    },
                  ),
                  Spacer(),
                  FloatingActionButton(
                    backgroundColor: prefix.Colors.redAccent,
                    onPressed: () {
                      print("START");
                    },
                  ),
                  Spacer(),
                  FloatingActionButton(
                    backgroundColor: prefix.Colors.redAccent,
                    onPressed: () {
                      print("スポット");
                    },
                  ),
                  Spacer(),
                ],
              ),
            ),
            Spacer(),
            Container(
              width: mediaWidth/1.5,

            ),
            Spacer(),
            Container(
              width: mediaWidth/1.3,
              height: mediaHeight/11,
              decoration: const BoxDecoration( // 背景
                  image: DecorationImage(
                    image: AssetImage('assets/images/photoConPage.png'),
                    fit: BoxFit.cover,
                  )
              ),

              child: Text("フォトコンテスト",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: prefix.Colors.white,
                  fontWeight: FontWeight.bold,

                ),
              ),
            ),
            Spacer(),
            SizedBox(
              width: mediaWidth/1.2,
              height: mediaHeight/15,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: prefix.Colors.red[300],
                  onPrimary: prefix.Colors.white,
                  shape: const StadiumBorder(),
                ),
                onPressed: () {},
                child: Text(
                  "Webサイトへ",
                ),
              ),
            ),
            Spacer(),
          ],
        ),

      )
    );
  }

}
