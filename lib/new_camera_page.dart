import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:touchable/touchable.dart';
import 'package:yuwaku_proto/some_top_page.dart';
import 'package:camera/camera.dart';

class NewCameraPage extends StatefulWidget {
  const NewCameraPage({Key? key, required this.camera}) : super(key: key);
  final CameraDescription camera;

  @override
  _NewCameraPage createState() => _NewCameraPage(camera: camera);
}

class _NewCameraPage extends State<NewCameraPage> {
  _NewCameraPage({Key? key, required this.camera});
  final CameraDescription camera;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(186, 66, 43, 1),
        title: Text('スタンプ登録確認'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 30,
              child: Image.asset('assets/images/Yakushizi1.png',
                  fit: BoxFit.cover),
            ),
            Expanded(
              flex: 4,
              child: Stack(
                children: [
                  Container(
                    color: Color.fromRGBO(240, 233, 208, 1),
                    child: Align(
                      alignment: Alignment(0, -10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      RunTopPage(camera: camera),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              color: Color.fromRGBO(236, 104, 22, 1),
                              ),
                              height: MediaQuery.of(context).size.height * 0.09,
                              width: MediaQuery.of(context).size.width / 2.8,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.approval,
                                      color: Colors.white,
                                      size: MediaQuery.of(context).size.width /
                                          13),
                                  Text(
                                    '押す',
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                              color: Color.fromRGBO(90, 197, 234, 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: MediaQuery.of(context).size.height * 0.09,
                              width: MediaQuery.of(context).size.width / 2.8,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.refresh,
                                      color: Colors.white,
                                      size: MediaQuery.of(context).size.width /
                                          13),
                                  Text(
                                    'やり直す',
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
