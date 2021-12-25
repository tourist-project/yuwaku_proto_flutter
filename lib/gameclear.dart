import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class clearpage extends StatelessWidget {
  double width, height;
  clearpage(this.width, this.height);

  // 表示する写真を入れる
  var imagephoto = [
    'assets/images/img1_gray.png',
    'assets/images/img2_gray.png',
    'assets/images/KeigoSirayu.png',
    'assets/images/map_img.png'
  ];

  Future<void> _launchURL() async {
    const url = "https://totteku.tourism-project.com/";
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  // 写真を表示する
  Widget photogoal(final image) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Image(image: AssetImage(image), fit: BoxFit.cover),
      ),
    );
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test'),
      ),
      body: Container(
        color: Color.fromRGBO(240, 233, 208, 1),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Row(
                children: <Widget>[
                  photogoal(imagephoto[0]),
                  photogoal(imagephoto[1]),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(children: <Widget>[
                photogoal(imagephoto[2]),
                photogoal(imagephoto[3]),
              ]),
            ),
            Expanded(
              flex: 5,
              child: Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: Color.fromRGBO(186, 66, 43, 1), width: 2),
                ),
                padding: const EdgeInsets.all(8),
                child: Scrollbar(
                  child: SingleChildScrollView(
                    child: Text(
                      ('TestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTest'),
                      style: TextStyle(fontSize: height / 40),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.all(5),
                width: 400,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: Color.fromRGBO(186, 66, 43, 1), width: 2),
                ),
                child: TextButton(
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      'フォトコンページに行く',
                      style:
                          TextStyle(fontSize: height / 30, color: Colors.black),
                    ),
                  ),
                  onPressed: () {
                     _launchURL();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
