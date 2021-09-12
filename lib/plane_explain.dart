import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:yuwaku_proto/map_page.dart';


/// 場所説明のページ作成予定
class PlaneExplain{

  final String name;
  final String planeExplain;
  final String initialImagePath;

  ui.Image initialPicture;

  PlaneExplain(this.name,this.planeExplain,this.initialImagePath,this.initialPicture);

}

class PicExplain extends StatefulWidget{

  PicExplain({Key? key, required this.title}) : super(key: key);

  final String title; /// ページタイトル

  /// 描画
  @override
  _PicExplain createState() => _PicExplain();

}

class _PicExplain extends State<PicExplain>{


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(

      ),

    );


  }
}
