import 'dart:typed_data';
import 'dart:ui';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:provider/provider.dart';
import 'package:yuwaku_proto/distance_goal_text.dart';
import 'package:yuwaku_proto/goal.dart';
import 'package:yuwaku_proto/homepage_component/homePage_Item.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:yuwaku_proto/saved_image_dialog.dart';
import 'package:yuwaku_proto/shared_preferences_manager.dart';
import 'package:yuwaku_proto/spot_image.dart';
import 'take_spot_notifier.dart';
import 'hint_dialog.dart';
import 'some_camera_page.dart';
import 'package:permission_handler/permission_handler.dart';

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
  final _sharedPreferencesManager = SharedPreferencesManager();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TakeSpotNotifier())
      ],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Card(
            child: Container(
              width: double.infinity,
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      height: 55,
                      child: Stack(
                        children: [
                          Center(
                            child: Text(
                                homeItems.title,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25
                                )
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: isTookPicture?
                            SizedBox(
                              width: 50,
                              height: 50,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xffcb5c63),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: IconButton(
                                  icon: Icon(Icons.download),
                                  color: Colors.white,
                                  onPressed: () async {
                                    final isAndroid = Platform.isAndroid; //OS判定
                                    final isIOS = Platform.isIOS;
                                    if(isAndroid){
                                      final androidStatus = await Permission.storage.request();
                                      print(PermissionStatus.granted);
                                      if (androidStatus.isGranted) { // 権限がある場合
                                        final result = await _saveImage(goal);
                                        if (result) {
                                          showSavedImageDialog(context);
                                        }
                                      }
                                    }else if(isIOS){
                                      final iosStatus = await Permission.photos.request();
                                      if (iosStatus.isGranted) { // 権限がある場合
                                        final result = await _saveImage(goal);
                                        if (result) {
                                          showSavedImageDialog(context);
                                        }
                                      }
                                    }

                                  }
                                ),
                              )
                            ):
                            Container(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SpotImage(goal),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DistanceGoalText(goal),
                      Container(
                        child: Row(
                          children: [
                            SizedBox(
                              width: 70,
                              height: 70,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: const Color(0xffcb5c63),
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
                                    Icon(
                                      Icons.lightbulb,
                                      color: Colors.white,
                                      size: 35,
                                    ),
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
                                  primary: const Color(0xffcb5c63),
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
                                    Icon(
                                      Icons.camera_alt_rounded,
                                      color: Colors.white,
                                      size: 35,
                                    ),
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
                  SizedBox(height: 10),
                ],
              ),
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

  Future<bool> _saveImage(Goal goal) async {
    final storagePath = await _sharedPreferencesManager.getImageStoragePath(goal);
    if (storagePath != null) {
        File roatedImage = await FlutterExifRotation.rotateImage(path: storagePath);
        final Uint8List imageBuffer = await roatedImage.readAsBytes();
        await ImageGallerySaver.saveImage(imageBuffer);
        return true;
    }
    return false;
  }

  void showSavedImageDialog(BuildContext context) async {
    await showDialog<void>(
        context: context,
        builder: (_) {
          return SavedImageDialog();
        });
  }
}
