import 'package:flutter/material.dart';
import 'dart:async';
import 'package:yuwaku_proto/camera_page.dart';
import 'package:yuwaku_proto/homepage_component/homePage_screen.dart';
import 'package:yuwaku_proto/homepage_component/homePage_Item.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:yuwaku_proto/map_page.dart';
import 'package:yuwaku_proto/map_painter.dart';
import 'ditance_calcuation.dart';


class RunTopPage extends StatefulWidget {
  const RunTopPage({Key? key}) : super(key: key);

  @override
  State<RunTopPage> createState() => _RunTopPage();
}

class _RunTopPage extends State<RunTopPage> {

  var i = 0, selectIndex = 0;

  List<HomePageItem> homeItems = [
    HomePageItem('氷室小屋', "Himurogoya",
      '氷室小屋は冷蔵施設がなく氷が大変貴重であった江戸時代に、大寒の雪を詰め'
          '天然の雪氷を夏まで長期保存するために作られた小屋です。湯涌ではこの雪詰めを体験'
          'できるイベントが開催されます。',
      'assets/images/HimuroGoya.png',
      36.48346516395541, 136.75701193508996,
    ),
    HomePageItem('金沢夢二館', "KanazawaYumejikan",
        '大正時代を代表する詩人画家の竹下夢二の記念館です。旅、女性、信仰心の3つ'
            'のテーマから、遺品や作品を通して夢二の芸術性や人間性を紹介しています。',
        'assets/images/Yumezikan.png',
        36.48584951599308, 136.75738876226737
    ),
    HomePageItem('総湯', "Soyu",
      '湯涌温泉の日帰り温泉。浴室はガラス窓であり、内湯でも開放的な気分になります。'
          '観光客だけでなく地元の方々にも日々利用されている名湯になります。',
      'assets/images/KeigoSirayu.png',
      36.485425901995455, 136.75758738535384,
    ),
    HomePageItem('足湯', "Ashiyu",
        '湯涌に2つある足湯の1つです。足だけの入浴なので無理なく体をしんから温める'
            'ことができます。無料なのでぜひ足湯を体験してみていかかでしょう。',
        'assets/images/Asiyu(temp).png',
        36.48582537854954, 136.7574341842218
    ),
    HomePageItem('みどりの里', "Midorinosato",
      '蕎麦打ち体験や梨の収穫体験などの様々なイベントが1年を通して行われます。'
          '4月中旬〜12月中旬の毎週日曜日と水曜日に朝市が開催され新鮮な農作物などをお買い求めいただけます。',
      'assets/images/MidorinoSato.png',
      36.49050881078798, 136.75404574490975,
    ),
  ];

  void onTapMove(int index){
    setState(() {
      selectIndex = index;
      if(i != 0)
        i = 0;
    });
  }

      
  @override
  Widget build(BuildContext context) {
    double heightSize = MediaQuery.of(context).size.height;
    double widthSize = MediaQuery.of(context).size.width;
    
    return Scaffold(
      body: ListView.builder( // 各要素の羅列
        itemCount: homeItems.length,
        itemBuilder: (BuildContext context, int index){
          return HomeClassTitleComponents(
            heightSize: heightSize,
            widthSize: widthSize,
            homeItems: homeItems[index],
          );
        },
      ),
    );
  }
}



/// 新しいホームページの構成Widget
class HomeClassTitleComponents extends StatelessWidget{

  // _RunTopPageからの情報をコンストラクタで取得
  HomeClassTitleComponents({
    required this.homeItems,
    required this.heightSize,
    required this.widthSize,
  });

  final double heightSize;
  final double widthSize;
  final HomePageItem homeItems;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightSize/3,
      width: widthSize,
      margin: EdgeInsets.all(5),
      color: Color.fromRGBO(240, 233, 208, 1),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: ((context) => HomeScreen())
                    ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(homeItems.image),
                    )
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                ShowDistancePosition(),
                Expanded(
                  child: Container(
                    color: Color.fromRGBO(186, 66, 43, 1),
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Text(
                        homeItems.explain,
                        style: TextStyle(
                            fontSize: 10, color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: InkWell(
                    onTap: (){
                      // Navigator.push(
                      //   context,
                      //    MaterialPageRoute(builder: ((context) => CameraPage(title: 'test', mapItem: )))
                      // )
                    },
                    child: Container(
                        child: Icon(Icons.photo_camera, size: 56)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//
// class ShowDistancePosition extends StatefulWidget {
//
//   const ShowDistancePosition({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   _ShowDistancePosition createState() => _ShowDistancePosition();
//
// }
//
// class _ShowDistancePosition extends State<ShowDistancePosition>{
//
//   List<HomePageItem> homeItems = [
//     HomePageItem('氷室小屋', "Himurogoya",
//       '氷室小屋は冷蔵施設がなく氷が大変貴重であった江戸時代に、大寒の雪を詰め'
//           '天然の雪氷を夏まで長期保存するために作られた小屋です。湯涌ではこの雪詰めを体験'
//           'できるイベントが開催されます。',
//       'assets/images/HimuroGoya.png',
//       36.48346516395541, 136.75701193508996,
//     ),
//     HomePageItem('金沢夢二館', "KanazawaYumejikan",
//         '大正時代を代表する詩人画家の竹下夢二の記念館です。旅、女性、信仰心の3つ'
//             'のテーマから、遺品や作品を通して夢二の芸術性や人間性を紹介しています。',
//         'assets/images/Yumezikan.png',
//         36.48584951599308, 136.75738876226737
//     ),
//     HomePageItem('総湯', "Soyu",
//       '湯涌温泉の日帰り温泉。浴室はガラス窓であり、内湯でも開放的な気分になります。'
//           '観光客だけでなく地元の方々にも日々利用されている名湯になります。',
//       'assets/images/KeigoSirayu.png',
//       36.485425901995455, 136.75758738535384,
//     ),
//     HomePageItem('足湯', "Ashiyu",
//         '湯涌に2つある足湯の1つです。足だけの入浴なので無理なく体をしんから温める'
//             'ことができます。無料なのでぜひ足湯を体験してみていかかでしょう。',
//         'assets/images/Asiyu(temp).png',
//         36.48582537854954, 136.7574341842218
//     ),
//     HomePageItem('みどりの里', "Midorinosato",
//       '蕎麦打ち体験や梨の収穫体験などの様々なイベントが1年を通して行われます。'
//           '4月中旬〜12月中旬の毎週日曜日と水曜日に朝市が開催され新鮮な農作物などをお買い求めいただけます。',
//       'assets/images/MidorinoSato.png',
//       36.49050881078798, 136.75404574490975,
//     ),
//   ];
//
//   Stream<Position>? geoLocator;
//   double locationNum = 0;
//   double? distance;
//
//   double get longitude => homeItems.longitude;
//   double get latitude => homeItems.latitude;
//
//   Stream<Position> positionStream() {
//     geoLocator = Geolocator.getPositionStream(
//       intervalDuration: Duration(seconds: 5),
//       desiredAccuracy: LocationAccuracy.best);
//     return geoLocator!;
//   }
//
//   void setDistance(Position position) {
//     this.distance = Geolocator.distanceBetween(
//         position.latitude, position.longitude, this.latitude, this.longitude);
//   }
//
//
//   @override
//   void initState(){
//     super.initState();
//     MapPainter.determinePosition().then((_){
//       Geolocator.getPositionStream(
//         intervalDuration: Duration(seconds: 5),
//         desiredAccuracy: LocationAccuracy.best,
//       ).listen((location) {
//
//     });
//   }
//
//   @override
//
// }
