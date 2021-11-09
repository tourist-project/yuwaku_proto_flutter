import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

double? width, height;

class clearpage extends StatelessWidget {
  // marginなどのサイズの指定
  @override
  Widget build(BuildContext context) {
    final widthsize = MediaQuery.of(context).size.width; // 横のスマホサイズの取得
    final heightsize = MediaQuery.of(context).size.height; // 縦のスマホサイズの取得
    width = widthsize;
    height = heightsize;
    // 表示する写真を入れる
    var imagephoto = [
      'assets/images/img1_gray.png',
      'assets/images/img2_gray.png',
      'assets/images/KeigoSirayu.png',
      'assets/images/map_img.png'
    ];
    List<String> posName = ["稲荷神社", "湯涌総湯中", "湯涌総湯外", "湯涌全体図"];
    return Scaffold(
      body: Scrollbar(
        // Scrollbarの表示
        isAlwaysShown: true,

        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Card(
                margin: EdgeInsets.symmetric(
                    vertical: heightsize / 52.0, horizontal: widthsize / 7.85),
                child: Container(
                  width: widthsize / 1.31,
                  height: heightsize / 11.1,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              Card(
                margin: EdgeInsets.symmetric(
                    vertical: heightsize / 22.3, horizontal: widthsize / 7.85),
                child: Container(
                  alignment: Alignment.center,
                  height: heightsize / 22.3,
                  width: widthsize / 1.1,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                  child: Text(
                    'ゴール!!!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: heightsize / 31.2,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),

              // imageの表示
              for (int i = 0; i < imagephoto.length; i++)
                redgoal(heightsize / 7.8 + (275 * i)),
              for (int i = 0; i < imagephoto.length; i++)
                textgoal(heightsize / 6.7 + (280 * i), posName[i]),
              for (int i = 0; i < imagephoto.length; i++)
                photogoal(heightsize / 4.8 + (280 * i), imagephoto[i]),
            ],
          ),
        ),
      ),
    );
  }
}

// 下地を表示する
Widget redgoal(double top) {
  return Card(
    margin: EdgeInsets.only(top: top),
    child: Center(
      child: Container(
        width: width! / 1.33,
        height: height! / 3.3,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    ),
  );
}

// テキストを表示する
Widget textgoal(double top, String text) {
  return Card(
    margin: EdgeInsets.only(top: top, left: width! / 8.0),
    child: Container(
      alignment: Alignment.center,
      width: width! / 1.5,
      height: height! / 23,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      child: Align(
        alignment: Alignment(0.2, 0.0),
        child: Text(
          text,
          style: TextStyle(
            fontSize: height! / 39,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    ),
  );
}

// 写真を表示する
Widget photogoal(double top, var image) {
  return Center(
    child: Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: top),
      child: Image(
          width: width! / 1.7, height: height! / 5.5, image: AssetImage(image)),
    ),
  );
}
