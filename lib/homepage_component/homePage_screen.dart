import 'package:yuwaku_proto/main.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'homePage_Item.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreen();

}

class _HomeScreen extends State<HomeScreen>{

  // final HomePageItem homeComponent = new HomePageItem();

  HomePageItem himuroItems = HomePageItem('氷室小屋', "Himurogoya",
      '氷室小屋は冷蔵施設がなく氷が大変貴重であった江戸時代に、大寒の雪を詰め'
          '天然の雪氷を夏まで長期保存するために作られた小屋です。湯涌ではこの雪詰めを体験'
          'できるイベントが開催されます。',
      'assets/images/HimuroGoya.png');

  HomePageItem Yumeji = HomePageItem('金沢夢二館', "KanazawaYumejikan",
      '大正時代を代表する詩人画家の竹下夢二の記念館です。旅、女性、信仰心の3つ'
          'のテーマから、遺品や作品を通して夢二の芸術性や人間性を紹介しています。',
      'assets/images/Yumezikan.png');

  HomePageItem Soyu = HomePageItem('総湯', "Soyu",
      '湯涌温泉の日帰り温泉。浴室はガラス窓であり、内湯でも開放的な気分になります。'
          '観光客だけでなく地元の方々にも日々利用されている名湯になります。',
      'assets/images/KeigoSirayu.png');

  HomePageItem Ashiyu = HomePageItem('足湯', "Ashiyu",
      '湯涌に2つある足湯の1つです。足だけの入浴なので無理なく体をしんから温める'
          'ことができます。無料なのでぜひ足湯を体験してみていかかでしょう。',
      'assets/images/Asiyu(temp).png');

  HomePageItem Midorinosato = HomePageItem('みどりの里', "Midorinosato",
      'みどりの里では、蕎麦打ち体験や梨の収穫体験などの様々なイベントが`1年を通して'
          '行われます。毎週日曜日と水曜日(4月中旬〜12月中旬)には湯涌朝市が開催され、非常に賑わって'
          'おります。湯涌の新鮮な農作物や加工品などをお買い求めいただけます。',
      'assets/images/MidorinoSato.png');


  @override
  Widget build(BuildContext context) {
    final mediaSize = MediaQuery.of(context).size;


    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar(
            pinned: true,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(

              title: Text(
                'トップページ',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
          ),

          SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 300.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 0.6,
            ),
            delegate:
            SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Card(
                      elevation: 15,
                      shadowColor: Colors.orange,
                      child: Column(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                  himuroItems.title
                              ),
                              Text(himuroItems.eng_title)
                            ],
                          ),

                          Card(
                            child: Image(
                              image: AssetImage(himuroItems.image),
                            ),
                          ),
                          Text(himuroItems.explain),
                        ],
                      ),
                    );
                    },

              childCount: 5,
            ),
          ),

          /*
          SliverFixedExtentList(
            itemExtent: 50.0,
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.lightBlue[100 * (index % 9)],
                  child: Text('List Item $index'),
                );
              },
            ),
          ),

           */
        ],
      )

    );
  }
}