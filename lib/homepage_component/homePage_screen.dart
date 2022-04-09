import 'package:flutter/cupertino.dart';
import 'package:yuwaku_proto/SizeConfig.dart';
import 'package:yuwaku_proto/main.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
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
  
