import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:yuwaku_proto/map_page.dart';
import 'package:flutter/material.dart' as prefix;
import 'package:url_launcher/url_launcher.dart';
import 'package:yuwaku_proto/plane_explain.dart';
import 'package:yuwaku_proto/tutorial_page.dart';

class TopPageView extends StatelessWidget{
  final ValueChanged<int> selectItem;

  TopPageView({required this.selectItem});

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('撮っテク!',
            style: TextStyle(
                color: prefix.Colors.black,
                fontStyle: FontStyle.normal
            ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(249,234,205,50),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/develop/TopView.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
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
            Expanded(
              flex: 5,
              child: FittedBox(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    text: '湯涌\nフォトラリー\n',
                    style: TextStyle(
                      color: prefix.Colors.white,
                      fontSize: 55,
                      fontWeight: FontWeight.bold,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: '写真を撮ってスタンプラリー',
                        style: TextStyle(
                          color: prefix.Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FittedBox(
                    child: ElevatedButton(
                      onPressed: () => selectItem(2),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.lightBlueAccent,
                        minimumSize: const Size(80.0, 80.0),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100), ),
                      ),
                      child: const Center(child: Text("遊び方", style: TextStyle(color: prefix.Colors.white))),
                    ),
                  ),
                  FittedBox(
                    child: ElevatedButton(
                      onPressed: () => selectItem(1),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.redAccent,
                        minimumSize: const Size(80.0, 80.0),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                      ),
                      child: const Center(child: Text("スタート", style: TextStyle(color: prefix.Colors.white, fontSize: 12.0))),
                    ),
                  ),
                  FittedBox(
                    child: ElevatedButton(
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PicExplain(title: '場所説明'))),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.orange,
                          minimumSize: const Size(80.0, 80.0),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                        ),
                        child: const Center(child: Text("スポット", style: TextStyle(color: prefix.Colors.white, fontSize: 12.0)))
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: FittedBox(
                child: ElevatedButton(
                  onPressed: () => _launchURLtoWebSite(),
                  style: ElevatedButton.styleFrom(
                    primary: prefix.Colors.red[300],
                    minimumSize: const Size(280, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Center(child: Text("Webサイトへ", style: TextStyle(color: prefix.Colors.white))),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.all(30.0)),
          ],
        ),
      ),
    );
  }
}

