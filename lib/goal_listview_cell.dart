import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yuwaku_proto/checkmark_image.dart';
import 'package:yuwaku_proto/homepage_component/homePage_screen.dart';
import 'package:yuwaku_proto/homepage_component/homePage_Item.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'checkmark_notifier.dart';
import 'homepage_component/homePage_screen.dart';
import 'some_camera_page.dart';

class GoalListViewCell extends StatelessWidget {
  GoalListViewCell(
      {required this.homeItems,
      required this.heightSize,
      required this.widthSize,
      required this.errorGetDistance,
      required this.camera});

  final CameraDescription camera;
  final double heightSize;
  final double widthSize;
  final HomePageItem homeItems;
  double? errorGetDistance;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CheckmarkNotifier(),
      child: Container(
        height: heightSize / 2.5,
        width: widthSize,
        margin: EdgeInsets.only(right: 5, left: 5, bottom: 20),
        decoration: BoxDecoration(
            color: Color.fromRGBO(240, 233, 208, 1),
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: ((context) => HomeScreen())),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black,
                          spreadRadius: 3,
                          blurRadius: 3,
                          offset: Offset(0, 3))
                    ],
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(homeItems.image),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 5, left: 5),
                            child: AutoSizeText(
                              '目的地まで',
                              style: TextStyle(fontSize: widthSize / 20),
                            ),
                          ),
                          homeItems.distance != null
                              ? Center(
                                  child: AutoSizeText(
                                    'あと' +
                                        homeItems.distance!.toStringAsFixed(1) +
                                        'm',
                                    style: TextStyle(fontSize: widthSize / 18),
                                  ),
                                )
                              : Center(
                                  child: Container(
                                    child: AutoSizeText(
                                      'データ取得中です',
                                      style:
                                          TextStyle(fontSize: widthSize / 20),
                                    ),
                                  ),
                                ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(186, 66, 43, 1),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Container(
                                child: Center(
                                  child: AutoSizeText(
                                    homeItems.title,
                                    style: TextStyle(
                                        fontSize: widthSize / 14,
                                        color: Colors.white),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black, width: 3),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: ((context) =>
                                              Camerapage(camera: camera)),
                                        ),
                                      );
                                    },
                                    child: Center(
                                      child: Column(
                                        children: [
                                          Icon(Icons.photo_camera_outlined,
                                              size: widthSize / 8),
                                          AutoSizeText('タップで写真ページへ',
                                              maxLines: 1)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 5),
                              Flexible(
                                flex: 1,
                                child: CheckmarkImage(true),
                              ),
                            ],
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
