import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:yuwaku_proto/camera_page.dart';
import 'package:yuwaku_proto/homepage_component/homePage_screen.dart';
import 'package:yuwaku_proto/homepage_component/homePage_Item.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:yuwaku_proto/map_component/map_page.dart';
import 'package:yuwaku_proto/map_component/map_painter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'homepage_component/homePage_screen.dart';
import 'package:camera/camera.dart';
import 'some_camera_page.dart';

class RunTopPage extends StatefulWidget {
  const RunTopPage({Key? key, required this.camera}) : super(key: key);

  final CameraDescription camera;
  @override
  State<RunTopPage> createState() => _RunTopPage(camera: camera);
}

class _RunTopPage extends State<RunTopPage> {
  _RunTopPage({Key? key, required this.camera});
  final CameraDescription camera;

  /*学校でテスト
  LC：36.5309848,136.6271052
  1号館：36.5309848,136.6271052
   */
  List<HomePageItem> homeItems = [
    HomePageItem(
      '氷室小屋',
      "Himurogoya",
      '氷室小屋は冷蔵施設がなく氷が大変貴重であった江戸時代に、大寒の雪を詰め'
          '天然の雪氷を夏まで長期保存するために作られた小屋です。湯涌ではこの雪詰めを体験'
          'できるイベントが開催されます。',
      'assets/images/HimuroGoya/HimuroGoya.png'
      36.48346516395541,
      136.75701193508996,
    ),
    HomePageItem(
        '金沢夢二館',
        "KanazawaYumejikan",
        '大正時代を代表する詩人画家の竹下夢二の記念館です。旅、女性、信仰心の3つ'
            'のテーマから、遺品や作品を通して夢二の芸術性や人間性を紹介しています。',
        'assets/images/Yumezikan/Yumezikan.png',
        36.48584951599308, 136.75738876226737
    ),
    HomePageItem(
      '総湯',
      "Soyu",
      '湯涌温泉の日帰り温泉。浴室はガラス窓であり、内湯でも開放的な気分になります。'
          '観光客だけでなく地元の方々にも日々利用されている名湯になります。',
      'assets/images/Soyu/KeigoSirayu.png',
      36.485425901995455, 136.75758738535384,
    ),
    HomePageItem(
        '足湯',
        "Ashiyu",
        '湯涌に2つある足湯の1つです。足だけの入浴なので無理なく体をしんから温める'
            'ことができます。無料なのでぜひ足湯を体験してみていかかでしょう。',
        'assets/images/Ashiyu/Asiyu(temp).png',
        36.48582537854954, 136.7574341842218
    ),
    HomePageItem('薬師寺', "Yakushizi",
      '蕎麦打ち体験や梨の収穫体験などの様々なイベントが1年を通して行われ,'
          '4月中旬〜12月中旬の毎週日曜日と水曜日に朝市が開催され新鮮な農作物などをお買い求めいただけます。',
      'assets/images/Yakushizi1.png',
      36.48566, 136.75794,
      )
  ];

  Stream<HomePageItem> _getStream() async* {
    MapPainter.determinePosition().then(
      (_) {
        Geolocator.getPositionStream(
          intervalDuration: Duration(seconds: 5),
          desiredAccuracy: LocationAccuracy.best,
        ).listen(
          (location) {
            for (var item in homeItems) {
              print(location);
              print('itemDistの距離${item.distance}');
              item.setDistance(location); // 距離関係を更新する
            }
          },
        );
      },
    );
  }

  @override
  void initState() {
    _getStream();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double heightSize = MediaQuery.of(context).size.height;
    double widthSize = MediaQuery.of(context).size.width;

    return SafeArea(
      child: StreamBuilder<HomePageItem>(
        stream: _getStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              body: SingleChildScrollView(
                child: Container(
                  width: widthSize,
                  height: heightSize * 3.1,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          margin: EdgeInsets.only(top: widthSize / 16, left: widthSize / 12),
                          width: widthSize,
                          height: heightSize / 16,
                          child: AutoSizeText('写真一覧', style: TextStyle(fontSize: widthSize / 12)),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(left: widthSize / 12, right: widthSize / 12),
                          width: widthSize,
                          height: heightSize / 30,
                          child: AutoSizeText('取った写真や、観光地の写真の一覧です。',
                              style: TextStyle(fontSize:  widthSize/24)),
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: Container(
                          width: widthSize,
                          height: heightSize/3,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: homeItems.length,
                            itemBuilder: (BuildContext context, int index){
                              return Container(
                                width: widthSize/2,
                                height: heightSize/3,
                                margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(homeItems[index].image),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          margin: EdgeInsets.only(top: widthSize / 12, left: widthSize / 12),
                          width: widthSize,
                          height: heightSize / 16,
                          child: AutoSizeText('目標一覧', style: TextStyle(fontSize: widthSize / 12)),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          // color: Colors.black,
                          margin: EdgeInsets.only(left: widthSize / 12, right: widthSize / 12),
                          width: widthSize,
                          height: heightSize / 20,
                          child: AutoSizeText(
                            '目標一覧です。写真をタップすると観光地の説明、ヒントを見ることが出来ます。',
                            style: TextStyle(fontSize: widthSize/10),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 35,
                        child: Container(
                          margin: EdgeInsets.only(top: widthSize / 18),
                          child: ListView.builder( 
                            shrinkWrap: true, 
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: homeItems.length,
                            itemBuilder: (BuildContext context, int index) {
                              return HomeClassTitleComponents(
                                homeItems: homeItems[index],
                                heightSize: heightSize,
                                widthSize: widthSize,
                                errorGetDistance: homeItems[index].distance,
                                camera: camera,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Expanded(
              flex: 20,
              child: Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}

/// 新しいホームページの構成Widget
class HomeClassTitleComponents extends StatelessWidget {
  // _RunTopPageからの情報をコンストラクタで取得
  HomeClassTitleComponents(
      {required this.homeItems,
      required this.heightSize,
      required this.widthSize,
      required this.errorGetDistance,
      required this.camera});

  final CameraDescription camera;
  final double heightSize;
  final double widthSize;
  final HomePageItem homeItems;
  double? errorGetDistance;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightSize / 2.5,
      width: widthSize,
      margin: EdgeInsets.only(right: 5, left: 5, bottom: 20),
      decoration: BoxDecoration(
          color: Color.fromRGBO(240, 233, 208, 1),
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: ((context) => HomeScreen())),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black,
                        spreadRadius: 3,
                        blurRadius: 3,
                        offset: Offset(0, 3))
                  ],
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(homeItems.image),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Container(
                            margin:  EdgeInsets.only(right: 5, left: 5),
                            child: AutoSizeText('目的地まで',
                                style: TextStyle(fontSize: widthSize / 20),
                            ),
                        ),
                        homeItems.distance != null
                            ? Center(
                                child: AutoSizeText(
                                  'あと' +
                                      homeItems.distance!.toStringAsFixed(1) +
                                      'm',
                                  style: TextStyle(fontSize: widthSize / 18),
                                ),
                              )
                            : Center(
                                child: Container(
                                  child: AutoSizeText(
                                    'データ取得中です',
                                    style: TextStyle(fontSize: widthSize / 20),
                                  ),
                                ),
                              ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(186, 66, 43, 1),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Container(
                              child: Center(
                                child: AutoSizeText(
                                  homeItems.title,
                                  style: TextStyle(
                                      fontSize: widthSize / 14,
                                      color: Colors.white),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 3),
                                borderRadius: BorderRadius.circular(10)),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: ((context) =>
                                        Camerapage(camera: camera)),
                                  ),
                                );
                              },
                              child: Center(
                                child: Column(
                                  children: [
                                    Icon(Icons.photo_camera_outlined,
                                        size: widthSize / 8),
                                    AutoSizeText(
                                        'タップで写真ページへ',
                                        maxLines: 1
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
