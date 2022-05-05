import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'Distance_twoPosition.dart';
import 'package:yuwaku_proto/homepage_component/homePage_Item.dart';
import 'package:yuwaku_proto/homepage_component/homePage_screen.dart';


class DemoDistance extends StatefulWidget{
  DemoDistance({Key? key}) : super(key: key);

  @override
  State<DemoDistance> createState() => _DemoDistance();
}

class _DemoDistance extends State<DemoDistance>{


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
        6.48584951599308, 136.75738876226737
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


  double? distance;// 距離



  String _location = "no data";

  Future<void> getLocation() async {
    // 現在の位置を返す
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // 北緯がプラス。南緯がマイナス
    print("緯度: " + position.latitude.toString());
    // 東経がプラス、西経がマイナス
    print("経度: " + position.longitude.toString());


    // 方位を返す
    double distanceBetween = Geolocator.distanceBetween(
        homeItems[0].latitude, homeItems[0].longitude,
        position.latitude,
        position.longitude);
    print(distanceBetween);

    setState(() {
      _location = position.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('位置情報やで'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$_location',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: getLocation, child: Icon(Icons.location_on)),
    );
  }
}