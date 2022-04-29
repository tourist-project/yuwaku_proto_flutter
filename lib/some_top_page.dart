import 'package:flutter/material.dart';
import 'dart:async';

import 'package:yuwaku_proto/camera_page.dart';
import 'package:yuwaku_proto/homepage_component/homePage_screen.dart';

class runTopPage extends StatefulWidget {
  const runTopPage({Key? key}) : super(key: key);

  @override
  State<runTopPage> createState() => _runTopPage();
}

class _runTopPage extends State<runTopPage> {  
  var i = 0, selectIndex = 0;
  
  @override
  void ontapmove(int index){
      setState(() {
        selectIndex = index;
        if(i != 0)
          i = 0;
      });
    }
      
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
       bottomNavigationBar: BottomNavigationBar(
         items: [
           BottomNavigationBarItem(icon: Icon(Icons.home),label: 'ホーム'),
           BottomNavigationBarItem(icon: Icon(Icons.photo_camera),label: 'カメラ'),
         ],
          onTap: ontapmove,
          currentIndex: selectIndex,
          
       ),

      body: selectIndex == 0 ?
      SingleChildScrollView(
        child: Column(
          children: <Widget>[
            for (i; i <= 5; i++)
              Container(
                height: size.height / 3,
                width: size.width,
                margin: EdgeInsets.all(5),
                color: Color.fromRGBO(240, 233, 208, 1),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: ((context) => HomeScreen()))
                          );
                        },
                        child:Container(
                          child: Image(
                              image: AssetImage('assets/images/KeigoSirayu.png'),
                              fit: BoxFit.cover),
                        ),
                    ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Container(
                                child: Container(
                                    margin: EdgeInsets.all(5),
                                    child: Column(children: [
                                      Container(
                                          width: double.infinity,
                                          child: Text('目的地まで',
                                              style: TextStyle(fontSize: 15),
                                              textAlign: TextAlign.left)),
                                      Text(
                                        '??m',
                                        style: TextStyle(fontSize: 25),
                                      )
                                    ])),
                              )),
                          Expanded(
                            flex: 2,
                            child: Container(
                              color:  Color.fromRGBO(186, 66, 43, 1),
                              child: Container(
                                margin: EdgeInsets.all(10),
                                child: Text(
                                  'この温泉は階段の上にあり、暫く奥にに歩いて行って、大きな博物館の近くにある。',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: (){
                                // Navigator.push(
                                //   context,
                                //    MaterialPageRoute(builder: ((context) => CameraPage(title: 'test', mapItem: )))
                                // )
                              },
                              child: Container(
                                child: Icon(Icons.photo_camera, size: 56)),),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
          ],
        ),
      ): Container(),
    );
  }
}
