import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

import 'package:simple_animations/simple_animations.dart';


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

  static final colorTween1 = ColorTween(begin: Color(0xffD38312), end: Colors.lightBlue.shade900);
  static final colorTween2 = ColorTween(begin: Color(0xffA83279), end: Colors.blue.shade600);

  final Image sun = Image.asset('asetts/image/NotKeigoSirayu.png');

  static const String _title = '第一ステージ';


  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;

    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text(_title),
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
                  Card(
                    elevation: 30.0,
                    color: Colors.white10,
                    margin: EdgeInsets.all(10),

                    child: Column(
                      children: <Widget>[
                        Text("湯涌総湯",
                          style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 36.0,),
                        ),

                        Container(
                          width: deviceWidth*0.9,

                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset('assets/images/KeigoSirayu.png'),
                          ),
                        ),

                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),

                          ),
                          margin: EdgeInsets.only(top: 10),

                          child: Text('養老二年（718年）近郷の農夫が泉に身を癒す白鷺をみてこの温泉を発見したと伝えられています。'
                              '藩政時代は、加賀藩の歴代藩主を始め一族が常用し、その効能によって治癒本復することがしばしばあり、これを賞され湯宿の主人に名字帯刀が許されたと言われます。'
                              '大正の初めドイツで開かれた万国鉱 泉博覧会に当時の内務省の推薦により日本の名泉として出展、泉質の良さが認められました。以来、文人墨客の来湯が繁くなり、特異な美人画で知られる大正の詩人、'
                              '竹久夢二が愛する女性彦乃を至福の日々を過ごした「ロマンの湯」としても知られています。'
                          ),
                        ),
                      ],
                    ),
                  ),


                  /// 2つ目の場所

                  Card(
                    elevation: 30.0,
                    color: Colors.white10,
                    margin: EdgeInsets.all(10),

                    child: Column(
                      children: <Widget>[
                        Text("湯涌総湯",
                          style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 36.0,),
                        ),

                        Container(
                          width: deviceWidth*0.9,

                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset('assets/images/KeigoSirayu.png'),
                          ),
                        ),

                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),

                          ),
                          margin: EdgeInsets.only(top: 10),

                          child: Text('養老二年（718年）近郷の農夫が泉に身を癒す白鷺をみてこの温泉を発見したと伝えられています。'
                              '藩政時代は、加賀藩の歴代藩主を始め一族が常用し、その効能によって治癒本復することがしばしばあり、これを賞され湯宿の主人に名字帯刀が許されたと言われます。'
                              '大正の初めドイツで開かれた万国鉱 泉博覧会に当時の内務省の推薦により日本の名泉として出展、泉質の良さが認められました。以来、文人墨客の来湯が繁くなり、特異な美人画で知られる大正の詩人、'
                              '竹久夢二が愛する女性彦乃を至福の日々を過ごした「ロマンの湯」としても知られています。'
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// ３つ目の場所
                  Card(
                    elevation: 30.0,
                    color: Colors.white10,
                    margin: EdgeInsets.all(10),

                    child: Column(
                      children: <Widget>[
                        Text("氷室小屋",
                          style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 36.0,),
                        ),

                        Container(
                          width: deviceWidth*0.9,

                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset('assets/images/KeigoSirayu.png'),
                          ),
                        ),

                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),

                          ),
                          margin: EdgeInsets.only(top: 10),

                          child: Text('加賀藩の初期には白山山系の倉谷村の氷室の氷が使われていたが、五代藩主綱紀公の頃、金沢市近郊や市内に多くの氷室が設けられ、'
                              '町民も氷を食する事が許された。しかし夏の氷は貴重品で、主に目上の人への贈答品などに使われ、庶民が食することは大変だったようであります'
                          'それで氷の代わりに麦で作った「氷室饅頭」を食べて無病息災を願う習慣だけが現在でも残っております。'
                          ),
                        ),
                      ],
                    ),
                  ),


                  /// 2つ目の場所

                  Card(
                    elevation: 30.0,
                    color: Colors.white10,
                    margin: EdgeInsets.all(10),

                    child: Column(
                      children: <Widget>[
                        Text("みどりの里",
                          style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 36.0,),
                        ),

                        Container(
                          width: deviceWidth*0.9,

                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset('assets/images/KeigoSirayu.png'),
                          ),
                        ),

                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),

                          ),
                          margin: EdgeInsets.only(top: 10),

                          child: Text('緑豊かな自然環境の中で、野菜づくりや農林産物の加工その他の農林業に関する体験等を通して、自然に親しむことができます。'
                              '農林業についての理解を深め、農林業の振興と周辺地域の活性化に資するための施設として、2002（平成14）年5月に開設されました。'
                              'ここでは蕎麦打ち体験や味噌作り体験などの、普段ではなかなか目にすることができない事を体験できます'
                          ),
                        ),
                      ],
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

