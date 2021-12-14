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
  
  List<String> posName = ["稲荷神社", "湯涌総湯中", "湯涌総湯外", "湯涌全体図"];
  
   _launchURL() async {
    const url = "https://totteku.tourism-project.com/";
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

    // 写真を表示する
    Widget photogoal(double top, double left, var image) {
      return Container(
        width: width / 2.125,
        height: height / 5.8,
        margin: EdgeInsets.only(top: top, left: left),
        child: Image(image: AssetImage(image),
        fit: BoxFit.cover),
      );
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test'),
      ),
      body: Container(
        color: Color.fromRGBO(240, 233, 208, 1),
        child:  Column(
        children: [
          Row(
            children: <Widget>[
              photogoal(height / 100, width/70, imagephoto[0]),
              photogoal(height / 100, width/30, imagephoto[1]),
            ],
          ),
          Row(children: <Widget>[
            photogoal(height / 100, width / 70, imagephoto[2]),
            photogoal(height / 100, width / 30, imagephoto[3]),
          ]),
          Container(
            margin: EdgeInsets.only(top: height / 100),
            height: height / 3.5,
            width: width / 1.02,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Color.fromRGBO(186, 66, 43, 1), width: 2),
            ),
            padding: const EdgeInsets.all(8),

            child:  Scrollbar(
              child: SingleChildScrollView(
                child: Text(
                  ('TestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTest'),
                  style: TextStyle(fontSize: height / 40),
                ),
              ),
            ),
          ),
          Container(
            height: height / 15,
            width: width / 1.02,
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Color.fromRGBO(186, 66, 43, 1), width: 2),
            ),
            child: TextButton(
              child: Text(
                'フォトコンページに行く',
                style: TextStyle(fontSize: height / 30, color: Colors.black),
              ),
              onPressed: () {
                _launchURL();
              },
            ),
          )
        ],
      ),
    ),
    );
  }
}

