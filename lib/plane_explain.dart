import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:flutter/animation.dart';
import 'package:simple_animations/simple_animations.dart';

/// FadeTransition使ってみる？


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

class _PicExplain extends State<PicExplain> with TickerProviderStateMixin{

  AnimationController? animationController,animationController1;
  Animation<Offset>? animation,animation1;

  final Image sun = Image.asset('asetts/image/NotKeigoSirayu.png');
  static const String _title = '第一ステージ';

  @override
  void initState(){
        animationController = AnimationController(
            duration: const Duration(milliseconds: 700), vsync: this
        );

        animation = Tween<Offset>(
            begin: const Offset(0.5, 0), end: Offset.zero
        ).animate(CurvedAnimation(
            parent: animationController!,
            curve: Curves.easeInOut));

        animation1 = Tween<Offset>(
            begin: const Offset(1, 0), end: Offset.zero
        ).animate(CurvedAnimation(
            parent: animationController!,
            curve: Curves.easeInOut));
  }


  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;
    animationController!.forward();

    return Material(
        child: Scaffold(
            appBar: AppBar(
              title: Text(_title,style: TextStyle(color: Colors.black87)),
            ),
            body: Center(
                child: Scrollbar(
                  isAlwaysShown: true,
                  thickness: 8,
                  hoverThickness: 16,
                  radius: Radius.circular(16),


                  child: SingleChildScrollView(
                      child: Column(
                          children: <Widget>[
                            /// 1つ目の場所

                            SlideTransition(
                              position: animation!,
                              child: Card(
                                margin: EdgeInsets.only(left: 20,right: 20, bottom: 15, top: 10),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                elevation: 10,

                                child: Column(
                                  children: <Widget>[
                                    Container(

                                      child: Image.asset('assets/images/KeigoSirayu.png'),
                                    ),
                                    Container(
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Container(
                                                child: Text(" 湯涌総湯",
                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0)
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Container(
                                                margin: EdgeInsets.only(left: deviceWidth/12),
                                                child: Text("Yuwaku Souyu",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.normal,
                                                        fontSize: 10,
                                                        color: Colors.black54
                                                    )
                                                ),

                                              ),
                                            ],
                                          ),

                                        ],

                                      ),
                                    ),

                                    Container(
                                      margin: EdgeInsets.all( 10),

                                      child: Text('養老二年（718年）近郷の農夫が泉に身を癒す白鷺をみてこの温泉を発見したと伝えられています。'
                                          '藩政時代は、加賀藩の歴代藩主を始め一族が常用し、その効能によって治癒本復することがしばしばあり、これを賞され湯宿の主人に名字帯刀が許されたと言われます。'
                                          '大正の初めドイツで開かれた万国鉱 泉博覧会に当時の内務省の推薦により日本の名泉として出展、泉質の良さが認められました。以来、文人墨客の来湯が繁くなり、特異な美人画で知られる大正の詩人、'
                                          '竹久夢二が愛する女性彦乃を至福の日々を過ごした「ロマンの湯」としても知られています。'
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            SlideTransition(
                              position: animation1!,

                              child: Card(
                                margin: EdgeInsets.only(left: 20,right: 20,bottom: 15),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                elevation: 10,

                                child: Column(
                                  children: <Widget>[
                                    Container(
                                        child: Image.asset('assets/images/KeigoSirayu.png')
                                    ),
                                    Container(
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Container(
                                                child: Text("湯涌総湯",
                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0)
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Container(
                                                margin: EdgeInsets.only(left: 15),
                                                child: Text("Yuwaku Souyu",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.normal,
                                                      fontSize: 10,
                                                      color: Colors.black54
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                      ),
                  ),
                ),
            ),
        ),
    );
  }
}