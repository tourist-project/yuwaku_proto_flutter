import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:yuwaku_proto/map_page.dart';
import 'package:flutter/material.dart' as prefix;
import 'package:url_launcher/url_launcher.dart';
import 'package:yuwaku_proto/plane_explain.dart';
import 'package:yuwaku_proto/tutorial_page.dart';

class TopPageView extends StatelessWidget{
  final ValueChanged<int> selectItem;

  TopPageView({required this.selectItem});


  final AppBar appBar = AppBar(
    title: Text('撮っテク!',
        style: TextStyle(
            color: prefix.Colors.black,
            fontStyle: FontStyle.normal)),
    centerTitle: true,
    backgroundColor: Color.fromRGBO(249,234,205,50),
  );

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
    final mediaWidth = MediaQuery.of(context).size.width;
    final mediaHeight = MediaQuery.of(context).size.height - appBar.preferredSize.height; // Appbarを除いた画面の大きさ

    return Scaffold(
      appBar: appBar,
      body: Container(
        decoration: const BoxDecoration( // 背景
            image: DecorationImage(
              image: AssetImage('assets/images/TopView.png'),
              fit: BoxFit.cover,
            ),
        ),
        height: mediaHeight,
        width: mediaWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Flexible( // 日付
              flex: 4,
              child: Opacity(
                opacity: 0.6,
                child: Container(
                  width: double.infinity,
                  color: prefix.Colors.black,
                  child: const FittedBox(
                    child: Text("2022年1月30日",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: prefix.Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Flexible( //フォトラリーWidget
              flex: 12,
              child: Container(
                width: double.infinity,
                height: mediaHeight/3,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text("湯涌\nフォトラリー",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: prefix.Colors.white,
                          fontSize: mediaWidth/7,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      child: Text("写真を撮ってスタンプラリー",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: prefix.Colors.white,
                          fontSize: mediaWidth/25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
            Spacer(),
            Expanded(
              flex: 2,
              child: Container(

              ),
            ),
            Flexible( // ボタン配置
              flex: 8,
              child: Row(
                children: <Widget>[
                  Spacer(),
                  RawMaterialButton(
                    onPressed: () => selectItem(2),
                    shape: CircleBorder(),
                    child: Container(
                      alignment: Alignment.center,
                      width: mediaWidth/5,
                      height: mediaHeight/8,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: prefix.Colors.lightBlueAccent,
                      ),
                      child:const Text("遊び方",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: prefix.Colors.white
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  RawMaterialButton(
                    onPressed: () => selectItem(1),
                    shape: CircleBorder(),
                    child: Container(
                      alignment: Alignment.center,
                      width: mediaWidth/5,
                      height: mediaHeight/8,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: prefix.Colors.redAccent
                      ),
                      child: const Text("スタート",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: prefix.Colors.white
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  RawMaterialButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PicExplain(title: '場所説明'))),
                    shape: CircleBorder(),
                    child: Container(
                      alignment: Alignment.center,
                      width: mediaWidth/5,
                      height: mediaHeight/8,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: prefix.Colors.orange
                      ),
                      child: const Text("スポット",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: prefix.Colors.white
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            /*
            Flexible(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Container( // フォトコン
                  width: mediaWidth/1.2,
                  height: mediaHeight/8,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration( // 背景
                    image: DecorationImage(
                      image: AssetImage('assets/images/photoConPage.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Text("フォトコンテスト",
                    style: TextStyle(
                        color: prefix.Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: mediaWidth/16
                    ),
                  ),
                ),
              ),
            ),*/
            Spacer(),
            Flexible( //webサイトに飛ぶ
              flex: 3,
              child: SizedBox(
                width: mediaWidth/1.2,
                height: mediaHeight/15,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: prefix.Colors.red[300],
                    onPrimary: prefix.Colors.white,
                    shape: const StadiumBorder(),
                  ),
                  onPressed: () => _launchURLtoWebSite(), // Webサイトに飛ぶ
                  child: Text("Webサイトへ"),
                ),
              ),
            ),
            Spacer()
          ],
        ),
      ),
    );
  }
}
