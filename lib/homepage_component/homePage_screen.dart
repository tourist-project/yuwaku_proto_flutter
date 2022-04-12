import 'package:flutter/cupertino.dart';
import 'package:yuwaku_proto/SizeConfig.dart';
import 'package:yuwaku_proto/main.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'homePage_Item.dart';
import 'package:auto_size_text/auto_size_text.dart';

List<modalItem>modalContents = [
  modalItem(
      'assets/images/HimuroGoya.png',
      'assets/images/HimuroGoya.png',
      'assets/images/HimuroGoya.png',
      'assets/images/HimuroGoya.png',
      '山の中にある小屋',
      '坂を登り、湖を囲む'
  ),
       
  modalItem(
    'assets/images/Yumezikan.png',
    'assets/images/Yumezikan.png',
    'assets/images/Yumezikan.png',
    'assets/images/Yumezikan.png',
    '中央の広場の近く',
    '総湯の近くにある'
  ),
       
  modalItem(
    'assets/images/KeigoSirayu.png',
    'assets/images/KeigoSirayu.png', 
    'assets/images/KeigoSirayu.png',
    'assets/images/KeigoSirayu.png',
    '大きな階段の近く',
    '奥には山が潜む'
  ),
         
  modalItem(
    'assets/images/Asiyu(temp).png',
    'assets/images/Asiyu(temp).png',
    'assets/images/Asiyu(temp).png', 
    'assets/images/Asiyu(temp).png',
    '階段の上にある',
    '上には神社を見る'
  ),
        
  modalItem(
    'assets/images/MidorinoSato.png',
    'assets/images/MidorinoSato.png', 
    'assets/images/MidorinoSato.png',
    'assets/images/MidorinoSato.png',
    '近くには赤い郵便ポストがある',
    '近くには大きな木がある'
  )
];

List<HomePageItem> homeItems = [
  HomePageItem('氷室小屋', "Himurogoya",
      '氷室小屋は冷蔵施設がなく氷が大変貴重であった江戸時代に、大寒の雪を詰め'
          '天然の雪氷を夏まで長期保存するために作られた小屋です。湯涌ではこの雪詰めを体験'
          'できるイベントが開催されます。',
      'assets/images/HimuroGoya.png'),

  HomePageItem('金沢夢二館', "KanazawaYumejikan",
      '大正時代を代表する詩人画家の竹下夢二の記念館です。旅、女性、信仰心の3つ'
          'のテーマから、遺品や作品を通して夢二の芸術性や人間性を紹介しています。',
      'assets/images/Yumezikan.png'),

  HomePageItem('総湯', "Soyu",
      '湯涌温泉の日帰り温泉。浴室はガラス窓であり、内湯でも開放的な気分になります。'
          '観光客だけでなく地元の方々にも日々利用されている名湯になります。',
      'assets/images/KeigoSirayu.png'),

  HomePageItem('足湯', "Ashiyu",
      '湯涌に2つある足湯の1つです。足だけの入浴なので無理なく体をしんから温める'
          'ことができます。無料なのでぜひ足湯を体験してみていかかでしょう。',
      'assets/images/Asiyu(temp).png'),

  HomePageItem('みどりの里', "Midorinosato",
      '蕎麦打ち体験や梨の収穫体験などの様々なイベントが1年を通して行われます。'
          '4月中旬〜12月中旬の毎週日曜日と水曜日に朝市が開催され新鮮な農作物などをお買い求めいただけます。',
      'assets/images/MidorinoSato.png'),
];

class HomeScreen extends StatefulWidget {

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreen();

}

class _HomeScreen extends State<HomeScreen>{
  @override
  Widget build(BuildContext context) {
    double mediaWidthSize = MediaQuery.of(context).size.width;
    double mediaHeightSize = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('トップページ'),
        backgroundColor: Colors.orange,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Container(
          color: Color(0xFFEAEAEA),
          child: Column(

            children: [
              SizedBox( // ここにMap(or Webサイト)へ飛ぶ機能
                height: mediaHeightSize/12,

              ),
              Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                        )
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
              SizedBox( // ここにWebサイト(or Map)に飛ぶ機能
                height: mediaHeightSize/10,

              )
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
                            Row(children: [
                              Expanded(
                                child: Image(image: AssetImage(modalContents[tapImage].Image_UpLeft)),
                              ),
                              Expanded(
                                child: Image(image: AssetImage(modalContents[tapImage].Image_UpRight))
                              ),
                            ]),
                            Row(children: [
                              Expanded(
                                child: Image(image: AssetImage(modalContents[tapImage].Image_DownLeft))
                              ),
                              Expanded(
                                child: Image(image: AssetImage(modalContents[tapImage].Image_DownRight))
                              ),
                            ]),
                          ]),
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
                            ),),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(top: 5),
                            child: Text(
                              'ヒント②: ${modalContents[tapImage].Hint_Down}',
                              style: TextStyle(fontSize: mediaWidthSize / 19.5),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            )
          );
        }
    );
  }
}
  
