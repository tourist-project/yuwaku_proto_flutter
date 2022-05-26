import 'package:flutter/material.dart';

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

  late AnimationController animationController;
  Animation<Offset>? animation,animation1;

  @override
  void initState(){
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000),
        vsync: this
    );

    animation = Tween<Offset>(
        begin: const Offset(0.4, 0),
        end: Offset.zero
    ).animate(CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut));

    animation1 = Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero
    ).animate(CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  // 各地点の名前と説明文
  List<String> posName = [/*" 金沢夢二館", " 湯涌みどりの里",*/ " 氷室小屋", " あし湯"];
  List<String> posEnglishName = [/*" KanazawaYumezikan", "YuwakuMidorinoSato" ,*/ "HimuroGoya", "Ashiyu"];
  List<String> posExplain = [
    //'大正時代を代表する詩人画家の竹下夢二の記念館です。旅、女性、信仰心の3つのテーマから、'
      //  '遺品や作品を通して夢二の芸術性や人間性を紹介しています。',
    //'みどりの里では、蕎麦打ち体験や梨の収穫体験などの様々なイベントが`1年を通して'
      //  '行われます。毎週日曜日と水曜日(4月中旬〜12月中旬)には湯涌朝市が開催され、非常に賑わって'
        //'おります。湯涌の新鮮な農作物や加工品などをお買い求めいただけます。',
    '氷室小屋は冷蔵施設がなく氷が大変貴重であった江戸時代に、大寒の雪を詰め天然の雪氷を夏まで長期保存'
        'するために作られた小屋です。湯涌ではこの雪詰めを体験できるイベントが開催されます。',
    '湯涌に2つある足湯の1つです。足だけの入浴なので無理なく体をしんから温めることができます。無料なので'
        'ぜひ足湯を体験してみていかかでしょう。'
  ];
  var imagePhoto = [
    //'assets/images/MidorinoSato.png',
    'assets/images/HimuroGoya.png',
    'assets/images/Asiyu(temp).png'
  ];


  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    animationController.forward();

    return Material(
        child: Scaffold(
            appBar: AppBar(title: Text('スポット説明',style: TextStyle(color: Colors.black87)),),
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
                                  child: Image.asset('assets/images/Yumezikan.png')
                              ),
                              Container(
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          child: Text("金沢夢二館",
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0)
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(left: 15),
                                          child: Text("KanazawaYumejikan",
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
                                child: Text('大正時代を代表する詩人画家の竹下夢二の記念館です。旅、女性、信仰心の3つのテーマから、'
                                    '遺品や作品を通して夢二の芸術性や人間性を紹介しています。'
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