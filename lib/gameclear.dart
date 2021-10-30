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
    double top = heightsize / 7.8, texttop = heightsize / 6.8, phototop = heightsize / 4.9;
    return Scaffold(
      body: Scrollbar(
        // Scrollbarの表示
        isAlwaysShown: true,

        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Card(
                margin: EdgeInsets.symmetric(
                    vertical: heightsize / 52.0,
                    horizontal: widthsize / 7.85),
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
                    vertical: heightsize / 22.3,
                    horizontal: widthsize / 7.85),
                child: Container(
                  alignment: Alignment.center,
                  height: heightsize / 22.3,
                  width: widthsize / 1.12,
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
              for (int i = 0; i <= 6; i++) redgoal(top + (275 * i)),
              for (int i = 0; i <= 6; i++) textgoal(texttop + (275 * i), '場所'),
              for (int i = 0; i <= 6; i++) photogoal(phototop + (275 * i), 'assets/images/img1_gray.png'),
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
        width: width! / 1.31,
        height: height! / 3.12,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    ),
  );
}

// テキストを表示する
Widget textgoal(double top, var text) {
  return Card(
    margin: EdgeInsets.only(top: top, left: width! / 17),
    child: Container(
      alignment: Alignment.center,
      width: width! / 1.48,
      height: height! / 26,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(60),
          bottomRight: Radius.circular(60),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: height! / 39,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    ),
  );
}

// 写真を表示する
Widget photogoal(double top, var image) {
  return Center(
    child: Container(
      margin: EdgeInsets.only(top: top),
      child: Image(
          width: width! / 1.57,
          height: height! / 4.59,
          image: AssetImage(image)),
    ),
  );
}
