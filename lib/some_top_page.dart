import 'package:flutter/material.dart';
import 'dart:async';
import 'package:yuwaku_proto/camera_page.dart';
import 'package:yuwaku_proto/homepage_component/homePage_screen.dart';
import 'package:yuwaku_proto/homepage_component/homePage_Item.dart';
import 'package:flutter/cupertino.dart';

class RunTopPage extends StatefulWidget {
  const RunTopPage({Key? key}) : super(key: key);

  @override
  State<RunTopPage> createState() => _RunTopPage();
}

class _RunTopPage extends State<RunTopPage> {

  List<HomePageItem> _homeItems = [
    HomePageItem('氷室小屋', "Himurogoya",
        '氷室小屋は氷が貴重であったので、保存するために作られた小屋です。',
        'assets/images/HimuroGoya.png'),
    HomePageItem('金沢夢二館', "KanazawaYumejikan",
        '大正時代を代表する詩人画家の竹下夢二の記念館です。',
        'assets/images/Yumezikan.png'),
    HomePageItem('総湯', "Soyu",
        '湯涌温泉の日帰り温泉。浴室はガラス窓であり、内湯でも開放的な気分になります。',
        'assets/images/KeigoSirayu.png'),
    HomePageItem('足湯', "Ashiyu",
        '湯涌に2つある足湯の1つです。',
        'assets/images/Asiyu(temp).png'),
    HomePageItem('みどりの里', "Midorinosato",
        '蕎麦打ち体験や梨の収穫体験などのイベントが1年を通して行われます。',
        'assets/images/MidorinoSato.png'),
  ];

  @override
  Widget build(BuildContext context) {
    double heightSize = MediaQuery.of(context).size.height;
    double widthSize = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ListView.builder( // 各要素の羅列
        itemCount: _homeItems.length,
        itemBuilder: (BuildContext context, int index){
          return HomeClassTitleComponents(
            heightSize: heightSize,
            widthSize: widthSize,
            homeExplain: _homeItems[index].explain,
            homeImages: _homeItems[index].image,
            indexCount: index,
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
    required this.homeExplain,
    required this.homeImages,
    required this.heightSize,
    required this.widthSize,
    required this.indexCount
  });

  final double heightSize;
  final double widthSize;
  final String homeExplain;
  final String homeImages;
  final int indexCount;

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
                      image: AssetImage(homeImages),
                    )
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
                      margin: EdgeInsets.all(5),
                      child: Column(
                          children: <Widget>[
                            Container(
                                width: double.infinity,
                                child: Text('目的地まで',
                                    style: TextStyle(fontSize: 15),
                                    textAlign: TextAlign.left)),
                            Center(
                              child: Text('??m',
                              style: TextStyle(fontSize: 30),
                            ),
                            ),
                          ]
                      )
                    ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(186, 66, 43, 1),
                      borderRadius: BorderRadius.circular(10.0),
                      /*
                      boxShadow:  [
                        BoxShadow(
                          color: Colors.black54,
                          spreadRadius: 1.0,
                          blurRadius: 10.0,
                          offset: Offset(5, 5),
                        ),
                      ],
                    ),*/
                      ),
                    child: Text(
                      homeExplain,
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
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
                    child: Center(
                        child: Icon(Icons.photo_camera, size: 56)),),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}