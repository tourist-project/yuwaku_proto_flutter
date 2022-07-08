import 'package:flutter/material.dart';

class Explain extends StatefulWidget{
  _Explain createState() => _Explain();
}

class _Explain extends State<Explain> with TickerProviderStateMixin {

  final String title = "場所説明";

  // アニメーションのコントローラー
  var _controller;
  var _color;

  // 初期化
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 120),
      vsync: this,
    )
      ..repeat(reverse: true);

    _color = ColorTween(begin: Color.fromRGBO(240, 233, 208, 1),
        end: Color.fromRGBO(186, 66, 43, 1)).animate(_controller);
  }

  //R:240,G:233,B:208
  //R:186,G:66,B:43


  // 不要になったWidgetの削除
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (context, contraint) {

        final double deviceHeight = MediaQuery.of(context).size.height;
        final double deviceWidth  = MediaQuery.of(context).size.width;

        return new Scaffold(
          appBar: AppBar(
            title: Text(title, style: TextStyle(color: Colors.black87)),
          ),

          body: AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {

              return Container(
                height: deviceHeight,
                width: deviceWidth,

                child: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(color: _color.value),
                    ),
                    
                    AppBackground(),
                    
                    Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment(-0.8, 0.5),
                          child: GestureDetector(
                            
                            onTap: () {
                              Navigator.pushNamed(context, '/plane_explain');
                            },

                            child: Container(
                              margin: EdgeInsets.only(left: 15, top: 60),
                              width: deviceWidth * 0.7,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black,
                                    offset: Offset(10.0, 15.0),
                                    blurRadius: 10,
                                    spreadRadius: 2.5
                                  )
                                ],
                              ),
                              child: Stack(
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.asset('assets/images/KeigoSirayu.png'),
                                  ),
                                  Text(
                                    '第一ステージ',
                                    style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                      color: Colors.green
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        
                        Spacer(),

                        Align(
                          alignment: Alignment(0.5, -0.5),
                          child: GestureDetector( 
                            child: Container(
                              margin: EdgeInsets.only(right: 15),
                              width: deviceWidth * 0.7,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black,
                                    offset: Offset(10.0, 15.0),
                                    blurRadius: 10,
                                    spreadRadius: 2.5
                                  )
                                ],
                              ),
                              child: Stack(
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.asset('assets/images/DeveloperPage.png'),
                                  ),
                                  Text('開発中', style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                      color: Colors.orangeAccent)
                                  ),
                                ],
                              ),
                            ),
                              
                            onTap:() {
                              Navigator.pushNamed(context, '/development_page');
                            },
                  
                          ),
                        ),
                        
                        Spacer(),
                          
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }
    );
  }
}

class AppBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder( 
      builder: (context, contraint) {
      
        final height = contraint.maxHeight;
        final width = contraint.maxWidth;

        return Stack(
          children: <Widget>[
            Positioned(
              top: height * 0.20,
              left: height * 0.35,
              child: Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white.withOpacity(0.2),
                ),
              ),
            ),
            Positioned(
              top: -height * 0.10,
              left: -height * 0.4,
              child: Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white.withOpacity(0.2),
                ),
              ),
            ),
          ],
        );
      }
    );
  }
}