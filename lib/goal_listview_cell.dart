import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yuwaku_proto/checkmark_image.dart';
import 'package:yuwaku_proto/distance_goal_text.dart';
import 'package:yuwaku_proto/goal.dart';
import 'package:yuwaku_proto/homepage_component/homePage_Item.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'checkmark_notifier.dart';
import 'some_camera_page.dart';

// ヒントの表示内容
List<modalItem> modalContents = [
    modalItem(
        'assets/images/HimuroGoya/HimuroGoya.png',
        'assets/images/HimuroGoya/Himuro2.png',
        'assets/images/HimuroGoya/HimuroGoya3.png',
        'assets/images/HimuroGoya/HimuroGoya4.png',
        '山の中にある小屋',
        '坂を越えた先に見える'
    ),

    modalItem(
        'assets/images/Yumezikan/Yumezikan1.JPG',
        'assets/images/Yumezikan/Yumezikan2.JPG',
        'assets/images/Yumezikan/Yumezikan4.png',
        'assets/images/Yumezikan/Yumezikan.png',
        '中央の広場の近く',
        '総湯の近くにある'
    ),

    modalItem(
        'assets/images/Soyu/Soyu1.png',
        'assets/images/Soyu/Soyu2.png',
        'assets/images/Soyu/Soyu3.jpg',
        'assets/images/Soyu/Modal_Soyu.png',
        '大きな階段の近く',
        '奥には山が潜む'
    ),

    modalItem(
        'assets/images/Ashiyu/Ashiyu1.jpg',
        'assets/images/Ashiyu/Ashiyu2.png',
        'assets/images/Ashiyu/Ashiyu3.png',
        'assets/images/Ashiyu/Asiyu(temp).png',
        '階段の上にある',
        '上には神社を見る'
    ),
    modalItem(
        'assets/images/Yakushizi1.png',
        'assets/images/Yakushizi2.png',
        'assets/images/Yakushizi3.JPG',
        'assets/images/YakushiziBack.jpg',
        '山の中にある神社',
        '稲荷神社から見えるかも？'
    ),
  ];

class GoalListViewCell extends StatelessWidget {
  
  GoalListViewCell({
      required this.index,
      required this.goal,
      required this.heightSize,
      required this.widthSize,
      required this.homeItems,
      required this.camera,
      required this.isTookPicture,
      required this.errorGetDistance,
  });

  final int index;
  final Goal goal;
  final double heightSize;
  final double widthSize;
  final HomePageItem homeItems;
  final CameraDescription camera;
         bool isTookPicture;
         double? errorGetDistance;

  @override
  Widget build(BuildContext context) {
    
    Widget print_hint_image(double mediaHeight, double mediaWidth, int tapImage, String image) {
      return Expanded(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Container(
            width: mediaWidth    / 4,
            height: mediaHeight /  7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      );
    }
    
    // ここのクラス？は、何故かここに置かないと使えない。
    @override
    Future<void> displayModal(int tapImage){
      double mediaWidthSize =  MediaQuery.of(context).size.width;
      double mediaHeightSize = MediaQuery.of(context).size.height;
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: mediaHeightSize / 1.80,
                child: Column(
                  children: [
                    Expanded(
                      flex: 8,
                      child: Container(
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  print_hint_image(mediaHeightSize, mediaWidthSize, tapImage, modalContents[tapImage].Image_UpLeft),
                                  print_hint_image(mediaHeightSize, mediaWidthSize, tapImage, modalContents[tapImage].Image_UpRight),
                                ]
                              ),
                              Row(
                                children: [
                                  print_hint_image(mediaHeightSize, mediaWidthSize, tapImage, modalContents[tapImage].Image_DownLeft),
                                  print_hint_image(mediaHeightSize, mediaWidthSize, tapImage, modalContents[tapImage].Image_DownRight),
                                ]
                              ),
                            ]
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'ヒント①: ${modalContents[tapImage].Hint_Up}',
                                style: TextStyle(fontSize: mediaWidthSize / 22),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(top: 5),
                              child: Text(
                                'ヒント②: ${modalContents[tapImage].Hint_Down}',
                                style: TextStyle(fontSize: mediaWidthSize / 22),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ]
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
    // クラスここまで
    
    return ChangeNotifierProvider(
      create: (_) => CheckmarkNotifier(),
      child: Container(
        height: heightSize / 2.5,
        width: widthSize,
        margin: EdgeInsets.only(right: 5, left: 5, bottom: 20),
        decoration: BoxDecoration(
          color: Color.fromRGBO(240, 233, 208, 1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  displayModal(this.index);
                },
                child: Stack(
                  children: <Widget>[ 
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            spreadRadius: 3,
                            blurRadius: 3,
                            offset: Offset(0, 3),
                          )
                        ],
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(homeItems.image),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        height: widthSize / 4.5,
                        width:  widthSize / 4.5,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.5)
                        ),
                        child: Center(
                          child: Icon(
                            Icons.lightbulb,
                            size: widthSize / 8,
                          ),
                        ),
                      ),
                    ),
                  ],
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
                          Expanded(
                            flex: 1,
                              child: DistanceGoalText(goal)
                          ),
                          homeItems.distance != null
                          ? Center(
                              child: AutoSizeText(
                                'あと' + homeItems.distance!.toStringAsFixed(0) + 'm',
                                style: TextStyle(fontSize: widthSize / 18),
                              ),
                            )
                          : Center(
                              child: AutoSizeText(
                                'データ取得中です',
                                style:TextStyle(fontSize: widthSize / 20),
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
                                      color: Colors.white
                                    ),
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
                                    border: Border.all(color: Colors.black, width: 3),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: ((context) => Camerapage(camera: camera, goal: goal)),
                                        ),
                                      );
                                    },
                                    child: Center(
                                      child: Column(
                                        children: [
                                          Icon(Icons.photo_camera_outlined, size: widthSize / 8),
                                          Text('撮ってく？', maxLines: 1, style: TextStyle(fontSize: widthSize / 27.5)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 5),
                              Flexible(
                                flex: 1,
                                child: CheckmarkImage(!isTookPicture),
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