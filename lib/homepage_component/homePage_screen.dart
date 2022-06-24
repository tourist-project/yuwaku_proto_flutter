import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'homePage_Item.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:yuwaku_proto/homepage_component/homePage_Item.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen>{

  List<modalItem> modalContents = [

    modalItem(
        'assets/images/HimuroGoya/HimuroGoya.png',
        'assets/images/HimuroGoya/Himuro2.png',
        'assets/images/HimuroGoya/HimuroGoya3.png',
        'assets/images/HimuroGoya/HimuroGoya4.png',
        '山の中にある小屋',
        '坂を登り、湖を囲む'
    ),

    modalItem(
        'assets/images/Yumezikan/Yumezikan1.JPG',
        'assets/images/Yumezikan/Yumezikan4.png',
        'assets/images/Yumezikan/Yumezikan2.JPG',
        'assets/images/Yumezikan/Yumezikan.png',
        '中央の広場の近く',
        '総湯の近くにある'
    ),

    modalItem(
        'assets/images/Soyu/Soyu3.jpg',
        'assets/images/Soyu/Modal_Soyu.png',
        'assets/images/Soyu/Soyu1.png',
        'assets/images/Soyu/Soyu2.png',
        '大きな階段の近く',
        '奥には山が潜む'
    ),

    modalItem(
        'assets/images/Ashiyu/Ashiyu2.png',
        'assets/images/Ashiyu/Ashiyu3.png',
        'assets/images/Ashiyu/Asiyu(temp).png',
        'assets/images/Ashiyu/Ashiyu1.jpg',
        '階段の上にある',
        '上には神社を見る'
    ),
    modalItem(
        'assets/images/Yakushizi1.png',
        'assets/images/Yakushizi2.png',
        'assets/images/Yakushizi3.JPG',
        'assets/images/YakushiziBack.jpg',
        '山の中にある神社',
        '稲荷神社から見えるかも？'
    ),
  ];

  List<HomePageItem> homeItems = [
    HomePageItem('氷室小屋', "Himurogoya",
      '氷室小屋は冷蔵施設がなく氷が大変貴重であった江戸時代に、大寒の雪を詰め'
          '天然の雪氷を夏まで長期保存するために作られた小屋です。湯涌ではこの雪詰めを体験'
          'できるイベントが開催されます。',
      'assets/images/HimuroGoya/HimuroGoya.png',
      36.48346516395541, 136.75701193508996,
    ),
    HomePageItem('金沢夢二館', "KanazawaYumejikan",
        '大正時代を代表する詩人画家の竹下夢二の記念館です。旅、女性、信仰心の3つ'
            'のテーマから、遺品や作品を通して夢二の芸術性や人間性を紹介しています。',
        'assets/images/Yumezikan/Yumezikan.png',
        6.48584951599308, 136.75738876226737
    ),
    HomePageItem('総湯', "Soyu",
      '湯涌温泉の日帰り温泉。浴室はガラス窓であり、内湯でも開放的な気分になります。'
          '観光客だけでなく地元の方々にも日々利用されている名湯になります。',
      'assets/images/Soyu/KeigoSirayu.png',
      36.485425901995455, 136.75758738535384,
    ),
    HomePageItem('足湯', "Ashiyu",
        '湯涌に2つある足湯の1つです。足だけの入浴なので無理なく体をしんから温める'
            'ことができます。無料なのでぜひ足湯を体験してみていかかでしょう。',
        'assets/images/Ashiyu/Asiyu(temp).png',
        36.48582537854954, 136.7574341842218
    ),

    HomePageItem('薬師寺', "Yakushizi",
      '湯涌温泉開湯の祖！！\n'
          '薬師寺には薬師如来が祀られています',
      'assets/images/Yakushizi1.png',
      36.48566, 136.75794,
    ),
    //
    // HomePageItem('みどりの里', "Midorinosato",
    //   '蕎麦打ち体験や梨の収穫体験などの様々なイベントが1年を通して行われます。'
    //       '4月中旬〜12月中旬の毎週日曜日と水曜日に朝市が開催され新鮮な農作物などをお買い求めいただけます。',
    //   'assets/images/MidorinoSato.png',
    //   36.49050881078798, 136.75404574490975,
    // ),
  ];

  Future<void> _launchURLtoWebSite() async{
    const url = "https://totteku.tourism-project.com/";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not Launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    double mediaWidthSize = MediaQuery.of(context).size.width;
    double mediaHeightSize = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: Text('トップページ'), backgroundColor: Colors.orange,),
      backgroundColor: Colors.white,
      body: SafeArea(
          bottom: false,
          child: Container(
            color: Color(0xFFEAEAEA),
            child: Column(
              children: [
                SizedBox( // ここにMap(or Webサイト)へ飛ぶ機能
                  height: mediaHeightSize/12,
                  child: FittedBox(
                    child: ElevatedButton(
                      onPressed: () => _launchURLtoWebSite(),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red[300],
                        minimumSize: const Size(280, 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Center(
                          child: Text("撮っテクのWebサイトへ", style: TextStyle(color: Colors.white))),
                    ),
                  ),

                ),

                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                    ),
                    child: GridView.builder(
                        itemCount: homeItems.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.9,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            elevation: 20,
                            shadowColor: Colors.deepOrange,
                            child: GestureDetector( //ボタン押下
                              onTap: () {
                                displayModal(index);
                              },
                              child: Column(
                                children: <Widget>[
                                  Flexible(
                                    flex: 2,
                                    child: Column(
                                      children: <Widget>[
                                        Flexible(
                                          flex: 2,
                                          child: AutoSizeText(
                                            homeItems[index].title,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: mediaHeightSize/30,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Flexible(
                                          flex: 1,
                                          child: AutoSizeText(
                                            homeItems[index].eng_title,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: mediaHeightSize/50,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                    flex: 5,
                                    child: Card(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5.0),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(homeItems[index].image),
                                            )
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
              ),
            ],
          ),
        )
      ),
    );
  }

  @override
  Future<void> displayModal(int tapImage) {
    double mediaWidthSize = MediaQuery.of(context).size.width;
    double mediaHeightSize = MediaQuery.of(context).size.height;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              content: GestureDetector(
                onTap: () {Navigator.pop(context);},
                child: Container(
                  height: mediaHeightSize / 1.80,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 8,
                        child: Container(
                          child: Center(
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Container(
                                              width: mediaWidthSize / 4,
                                              height: mediaHeightSize/7,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10.0),
                                                image: DecorationImage(
                                                  image: AssetImage(modalContents[tapImage].Image_UpLeft),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width: mediaWidthSize / 4,
                                              height: mediaHeightSize/ 7 ,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10.0),
                                                image: DecorationImage(
                                                  image: AssetImage(modalContents[tapImage].Image_UpRight),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),

                                      ]
                                  ),
                                  Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width: mediaWidthSize / 4,
                                              height: mediaHeightSize/ 7,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10.0),
                                                image: DecorationImage(
                                                  image: AssetImage(modalContents[tapImage].Image_DownLeft),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width: mediaWidthSize / 4,
                                              height: mediaHeightSize/ 7,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10.0),
                                                image: DecorationImage(
                                                  image: AssetImage(modalContents[tapImage].Image_DownRight),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]
                                  ),
                                ]
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'ヒント①: ${modalContents[tapImage].Hint_Up}',
                                    style: TextStyle(fontSize: mediaWidthSize / 19.5),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(top: 5),
                                  child: Text(
                                    'ヒント②: ${modalContents[tapImage].Hint_Down}',
                                    style: TextStyle(fontSize: mediaWidthSize / 19.5),
                                  ),
                                ),
                              ]
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          );
        });
  }
}
