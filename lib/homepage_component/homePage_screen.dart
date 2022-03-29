import 'package:flutter/cupertino.dart';
import 'package:yuwaku_proto/main.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:yuwaku_proto/map_page.dart';
import 'homePage_Item.dart';
import 'package:auto_size_text/auto_size_text.dart';



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
                height: mediaHeightSize/8,
                child: Container(
                  color: Colors.red,
                  child: GestureDetector(
                    onTap:() {
                      print("地図画面に飛ぶよ");
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MapPage(title: '地図')));
                    },
                  ),
                ),

              ),
              Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
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
                                printModal(index);
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
  Future<void> printModal(int tapImage) {
    double mediaWidthSize = MediaQuery.of(context).size.width;
    double mediaHeightSize = MediaQuery.of(context).size.height;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: GestureDetector(
            onTap: () {Navigator.pop(context);},
              child: Container(
                height: mediaHeightSize / 1.35,
                    child: Column(
                    children: [
                    Expanded(
                      flex: 3,
                        child: Container(
                          child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                            Row(children: [
                              Expanded(
                                child: Image(image: AssetImage(homeimages[tapImage].Image)),
                              ),
                              Expanded(
                                child: Image(image: AssetImage(homeimages[tapImage].Image2))
                              ),
                            ]),
                            Row(children: [
                              Expanded(
                                child: Image(image: AssetImage(homeimages[tapImage].Image3))
                              ),
                              Expanded(
                                child: Image(image: AssetImage(homeimages[tapImage].Image4))
                              ),
                            ]),
                          ]),
                        ),
                        ),
                    ),
                    Expanded(
                      flex: 4,
                       child: Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Center(
                         child: Column(
                           mainAxisSize: MainAxisSize.min,
                           children: [
                            Text(
                              'ヒント①: ヒントヒントヒントヒントヒントヒントヒントヒントヒントヒント',
                              style: TextStyle(fontSize: mediaWidthSize / 19.5),
                            ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Text(
                              'ヒント②: ヒントヒントヒントヒントヒントヒントヒントヒントヒントヒントヒントヒントヒントヒント',
                              style: TextStyle(fontSize: mediaWidthSize / 19.5),
                            ),
                          ),
                        ]),
                      ),
                    ),)
                  ],
                ),
              ),
            )
          );
        }
    );
  }
}
  