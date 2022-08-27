import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yuwaku_proto/checkmark_image.dart';
import 'package:yuwaku_proto/distance_goal_text.dart';
import 'package:yuwaku_proto/goal.dart';
import 'package:yuwaku_proto/homepage_component/homePage_Item.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:yuwaku_proto/spot_image.dart';
import 'checkmark_notifier.dart';
import 'hint_dialog.dart';
import 'some_camera_page.dart';

class GoalListViewCell extends StatelessWidget {
  GoalListViewCell(
      {required this.homeItems,
      required this.heightSize,
      required this.widthSize,
      required this.errorGetDistance,
      required this.camera,
      required this.isTookPicture,
      required this.goal});

  final CameraDescription camera;
  final double heightSize;
  final double widthSize;
  final HomePageItem homeItems;
  double? errorGetDistance;
  bool isTookPicture;
  final Goal goal;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CheckmarkNotifier())
      ],
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Container(
            width: double.infinity,
            color: Colors.white,
            child: Column(
              children: [
                Text(
                  homeItems.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25
                  ),
                ),
                SpotImage(goal),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('あと 200m'),
                    Container(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 70,
                            height: 70,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromRGBO(186, 66, 43, 20),
                                onPrimary: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                )
                              ),
                              onPressed: () {
                                showHintDialog(context);
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.lightbulb, color: Colors.white),
                                  AutoSizeText('ヒント', maxLines: 1),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          SizedBox(
                            width: 70,
                            height: 70,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromRGBO(186, 66, 43, 20),
                                onPrimary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  )
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: ((context) =>
                                        Camerapage(camera: camera, goal: goal,)),
                                  ),
                                );
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.camera_alt_rounded),
                                  AutoSizeText('撮影', maxLines: 1),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
  }

  void showHintDialog(BuildContext context) async {
    await showDialog<void>(
        context: context,
        builder: (_) {
          return HintDialog(goal);
        });
  }
}
