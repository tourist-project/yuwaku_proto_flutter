import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;
import 'package:simple_animations/simple_animations.dart';
import 'package:yuwaku_proto/map_page.dart';
import 'dart:math';



class Explain extends StatefulWidget{

  _Explain createState() => _Explain();

}


class _Explain extends State<Explain> with TickerProviderStateMixin{

  final String title = "場所説明";

  // AnimationController _controller;
  // Animation<Color> _color;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   /// 繰り返し
  //   _controller = AnimationController(
  //     duration: Duration(milliseconds: 300),
  //     vsync: this, )
  //     ..repeat(reverse: true,);
  //
  //   _color = ColorTween(
  //     begin: Colors.red,
  //     end: Colors.orange,).animate(_controller);
  // }

 //
 //
 //
 // @override
 // void dispose() {
 //   _controller.dispose();
 //   super.dispose();
 // }



  @override
  Widget build(BuildContext context) {

    // 各種類の画面サイズ
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;


    return new Scaffold(
      appBar: AppBar(
        title: Text(title,style: TextStyle(color: Colors.black87)),
      ),

      body: Container(
        width: deviceWidth,
        height: deviceHeight,

        
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: FractionalOffset.topLeft,
            end: FractionalOffset.bottomRight,

            colors: [
              const Color(0xffe4a972).withOpacity(0.6),
              const Color(0xff9941d8).withOpacity(0.6),

            ],
          ),
        ),



        child: Container(
            height: deviceHeight,

            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment(-0.8, 0.5),

                  child: GestureDetector(

                    onTap: (){
                      Navigator.pushNamed(context, '/plane_explain');
                    },

                    child: Container(
                      margin: EdgeInsets.only(left: 15,top: 60),
                      width: deviceWidth*0.7,

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black87,
                              offset: Offset(10.0, 20.0),
                              blurRadius: 10,
                              spreadRadius: 3)
                        ],
                      ),
                      child: Stack(
                        children: <Widget>[

                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset('assets/images/KeigoSirayu.png'),
                          ),

                          Text('第一ステージ',
                              style:TextStyle(fontSize: 40,fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,color: Colors.green)
                          ),
                        ],
                      ),
                    ),
                  ),



                ),
                Spacer(),

                Align(
                  alignment: Alignment(0.5, -0.5),

                  child: Container(
                    margin: EdgeInsets.only(right: 15),
                    width: deviceWidth*0.7,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black87,
                            offset: Offset(10.0, 20.0),
                            blurRadius: 10,
                            spreadRadius: 3)
                      ],
                    ),

                    //　ここでInkWell使ってみる

                    child: Stack(

                      children: <Widget>[

                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),

                          child: Image.asset('assets/images/NotKeigoSirayu.png'),
                        ),

                        Text('第二ステージ', style:TextStyle(fontSize: 40,fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,color: Colors.orangeAccent)
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),

          ),

      ),
    );

  }
}

