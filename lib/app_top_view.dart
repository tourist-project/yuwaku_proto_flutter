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
import 'package:url_launcher/url_launcher.dart';

class topPageView extends StatelessWidget{

  final String name = "撮っテク!";

  _launchURLtoWebSite() async{
    const url = "https://totteku.tourism-project.com/";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not Launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaHeight = MediaQuery.of(context).size.height; // 画面の取得
    final mediaWidth = MediaQuery.of(context).size.width;
    return Scaffold(

      appBar: AppBar(
        title: Text(name,
            style: TextStyle(
              color: prefix.Colors.black,
              fontStyle: FontStyle.normal
            ),
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
            Spacer(),

            Container(
              width: mediaWidth,
              height: mediaHeight/3,
              child: Column(
                children: <Widget>[
                  Container(
                    child: Text("湯涌\nフォトラリー",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: prefix.Colors.white,
                        fontSize: mediaWidth/7,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    child: Text("写真を撮ってスタンプラリー",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: prefix.Colors.white,
                        fontSize: mediaWidth/25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),

            Container(
              child: Row(
                children: <Widget>[
                  Spacer(),
                  RawMaterialButton(
                    onPressed: () {
                      print("遊び方");
                    },
                    shape: CircleBorder(),
                    child: Container(
                      alignment: Alignment.center,
                      width: mediaWidth/5,
                      height: mediaHeight/8,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: prefix.Colors.lightBlueAccent,
                      ),
                      child:const Text("遊び方",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: prefix.Colors.white
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  RawMaterialButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/map_page');
                      print("START");
                    },
                    shape: CircleBorder(),
                    child: Container(
                      alignment: Alignment.center,
                      width: mediaWidth/5,
                      height: mediaHeight/8,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: prefix.Colors.redAccent
                      ),
                      child: const Text("スタート",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: prefix.Colors.white
                          ),
                      ),
                    ),
                  ),
                  Spacer(),
                  RawMaterialButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/plane_explain');
                      print("スポット");
                    },
                    shape: CircleBorder(),
                    child: Container(
                      alignment: Alignment.center,
                      width: mediaWidth/5,
                      height: mediaHeight/8,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: prefix.Colors.orange
                      ),
                      child: const Text("スポット",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: prefix.Colors.white
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),

            Spacer(),

            Container(
              width: mediaWidth/1.3,
              height: mediaHeight/11,
              alignment: Alignment.center,
              decoration: const BoxDecoration( // 背景
                  image: DecorationImage(
                    image: AssetImage('assets/images/photoConPage.png'),
                    fit: BoxFit.cover,
                  ),
              ),
              child: Text("フォトコンテスト",
                style: TextStyle(
                  color: prefix.Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: mediaWidth/16
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
                onPressed: () { // ここにWebサイトに飛ぶ処理
                  _launchURLtoWebSite();
                },
                child: Text(
                  "Webサイトへ",
                ),
              ),
            ),
            Spacer(),
          ],
        ),

      ),

    );
  }

}