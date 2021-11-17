import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:flutter/animation.dart';
import 'package:simple_animations/simple_animations.dart';

/// 場所説明のページ作成予定
class PlaneExplain{
  final String name;
  final String planeExplain;

  PlaneExplain(this.name,this.planeExplain);
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

  static const String _title = '第一ステージ';

  @override
  void initState(){
        animationController = AnimationController(
            duration: const Duration(milliseconds: 1000),
            vsync: this
        );

        animation = Tween<Offset>(
            begin: const Offset(0.4, 0), end: Offset.zero
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

  // 各地点の名前と説明文
  List<String> posName = [" 金沢夢二館", " 湯涌みどりの里", " 氷室小屋", " あし湯"];
  List<String> posEnglishName = [" KanazawaYumezikan", "YuwakuMidorinoSato", "HimuroGoya", "Ashiyu"];
  List<String> posExplain = [
    '大正時代を代表する詩人画家の竹下夢二の記念館です。旅、女性、信仰心の3つのテーマから、'
        '遺品や作品を通して夢二の芸術性や人間性を紹介しています。',
    'みどりの里では、蕎麦打ち体験や梨の収穫体験などの様々なイベントが`1年を通して'
        '行われます。毎週日曜日と水曜日(4月中旬〜12月中旬)には湯涌朝市が開催され、非常に賑わって'
        'おります。湯涌の新鮮な農作物や加工品などをお買い求めいただけます。',
    '氷室小屋は冷蔵施設がなく氷が大変貴重であった江戸時代に、大寒の雪を詰め天然の雪氷を夏まで長期保存'
        'するために作られた小屋です。湯涌ではこの雪詰めを体験できるイベントが開催されます。',
    '湯涌に2つある足湯の1つです。足だけの入浴なので無理なく体をしんから温めることができます。無料なので'
        'ぜひ足湯を体験してみていかかでしょう。'
  ];
  var imagePhoto = ['assets/images/Yumezikan.png',
    'assets/images/MidorinoSato.png',
    'assets/images/HimuroGoya.png',
    'assets/images/Asiyu(temp).png'];


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
                                          child: Text(" 総湯 白鷲の湯",
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0)
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(left: deviceWidth/12),
                                          child: Text(" Souyu Sirawasinoyu",
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
                              Container(
                                margin: EdgeInsets.all(10),
                                child: Text('湯涌温泉の日帰り温泉。浴室はガラス窓であり、内湯でも開放的な気分になります。'
                                    '観光客だけでなく地元の方々にも日々利用されている名湯になります。'
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
                                  child: Image.asset('assets/images/InariZinja.png'),
                              ),
                              Container(
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          child: Text(" 湯涌稲荷神社",
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0)
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(left: 15),
                                          child: Text(" YuwkuinariZinzya",
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
                              Container(
                                margin: EdgeInsets.all( 10),
                                child: Text('白鷲の湯と夢二館に挟まれた扇形の階段のさらに先にある神社です。アニメ「花咲くいろは」に'
                                    '登場した名所となっております。自然豊かの中にあるひっそりと佇む神社という風情あふれる風景を一度'
                                    'ご体験ください。'
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      for(int i = 0; i < posName.length; i++)
                        planeExplain(posName[i],posEnglishName[i], posExplain[i], imagePhoto[i]),

                    ],
                  ),
                ),
              ),
            ),
        ),
    );
  }
}




Widget planeExplain(String posName, String posEnglishName, String posExplain, var image){

  return Card(
    margin: EdgeInsets.only(left: 20,right: 20,bottom: 15),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 10,
    child: Column(
      children: <Widget>[
        Container(
            child: Image(image: AssetImage(image))
        ),
        Container(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    child: Text(posName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30.0)
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    child: Text(posEnglishName,
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
        Container(
          margin: EdgeInsets.all(10),
          child: Text(posExplain),
        ),
      ],
    ),
  );
}