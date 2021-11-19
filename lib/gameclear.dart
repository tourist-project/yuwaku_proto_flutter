import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yuwaku_proto/map_page.dart';

class clearpage extends StatelessWidget {
  double width, height;

  clearpage(this.width, this.height);

  // marginなどのサイズの指定
  @override
  Widget build(BuildContext context) {
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
                    vertical: height / 52.0, horizontal: width / 11),
                child: Container(
                  width: width / 1.0,
                  height: height / 11.1,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              Card(
                margin: EdgeInsets.symmetric(
                    vertical: height / 22.3, horizontal: width / 11),
                child: Container(
                  alignment: Alignment.center,
                  height: height / 22.3,
                  width: width,
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
                      fontSize: height / 31.2,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),

              // imageの表示
              for (int i = 0; i < imagephoto.length; i++)
                drawIndexPosition(i, posName, imagephoto) // imageの表示
            ],

          ),
        ),
      ),
    );
  }

  Widget drawIndexPosition(int currentIndex, posName, imagePhoto) {
    return Stack(
      children: <Widget>[
        redgoal(height / 7.8 + (275 * currentIndex), height, width),
        textgoal(height / 6.7 + (280 * currentIndex), posName[currentIndex], width, height),
        photogoal(height / 4.8 + (280 * currentIndex), imagePhoto[currentIndex], width, height)
      ],
    );
  }


// 下地を表示する
  Widget redgoal(double top, double height, double width) {
    return Card(
      margin: EdgeInsets.only(top: top),
      child: Center(
        child: Container(
          width: width / 1.33,
          height: height / 3.3,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }

// テキストを表示する
  Widget textgoal(double top, String text, double width, double height) {
    return Card(
      margin: EdgeInsets.only(top: top, left: width / 12.0),
      child: Container(
        alignment: Alignment.center,
        width: width / 1.5,
        height: height / 23,
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
              fontSize: height / 39,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

// 写真を表示する
  Widget photogoal(double top, var image, double width, double height) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: top),
        child: Image(
            width: width / 1.7, height: height / 5.5, image: AssetImage(image)),
      ),
    );
  }

}

