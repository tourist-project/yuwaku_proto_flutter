import 'package:flutter/cupertino.dart';
import 'package:yuwaku_proto/main.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import '../google_map_page.dart';
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
                child: GestureDetector(
                  onTap:() {
                    print("地図画面に飛ぶよ");
                    Navigator.push(context, MaterialPageRoute(builder: (context) => GoogleMapPage(title: '地図')));
                  },
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
                                // タップ時

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
}
