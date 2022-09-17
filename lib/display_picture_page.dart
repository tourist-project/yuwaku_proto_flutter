import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:yuwaku_proto/goal.dart';
import 'package:yuwaku_proto/shared_preferences_manager.dart';
import 'package:yuwaku_proto/take_spot_notifier.dart';
import 'documents_directory_client.dart';


class DisplayPicturePage extends StatelessWidget {
  DisplayPicturePage(
      {
        Key? key,
        required this.imagePath,
        required this.camera,
        required this.goal
      }
      ) : super(key: key);

  final String imagePath;
  final CameraDescription camera;
  final Goal goal;
  final _sharedPreferencesManager = SharedPreferencesManager();
  final _documentsDirectoryClient = DocumentsDirectoryClient();

  Future<void> _saveImageToDocumentsDirectory(String path, Goal goal) async {
    File savedImagePath = await _documentsDirectoryClient.saveImage(goal, path);
    await _sharedPreferencesManager.setImageStoragePath(
        goal, savedImagePath.path
    );
  }

  void _checkNotify(BuildContext context, Goal goal) {
    _sharedPreferencesManager.setIsTook(goal);
    switch (goal) {
      case Goal.himurogoya:
        context.read<TakeSpotNotifier>().notifyTakedHimurogoya();
        break;
      case Goal.yumejikan:
        context.read<TakeSpotNotifier>().notifyTakedYumejikan();
        break;
      case Goal.soyu:
        context.read<TakeSpotNotifier>().notifyTakedSoyu();
        break;
      case Goal.ashiyu:
        context.read<TakeSpotNotifier>().notifyTakedAshiyu();
        break;
      case Goal.yakushiji:
        context.read<TakeSpotNotifier>().notifyTakedYakushiji();
        break;
    }
  }

  void popToHome(BuildContext context) async {
    int count = 0;
    Navigator.of(context).popUntil((route) => count++ >= 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text('スタンプ登録確認',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromRGBO(240, 233, 208, 100),
          child: Column(
            children: [
              Center(
                child: SizedBox(
                    width: double.infinity,
                    child: Container(
                        width: double.infinity,
                        height: 500,
                        child: Image.file(File(imagePath))
                    )
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 15),
                  Expanded(
                    child: Container(
                      height: 60,
                      child: ElevatedButton(
                          onPressed:() async {
                            await _saveImageToDocumentsDirectory(imagePath, goal);
                            _checkNotify(context, goal);
                            popToHome(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffec6816),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ImageIcon(
                                AssetImage('assets/images/stamp.png'),
                                color: Colors.white,
                              ),
                              Text(
                                  '押す',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          )
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      height: 60,
                      child: ElevatedButton(
                          onPressed:() {
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff9fc5ea),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.refresh,
                                color: Colors.white,
                              ),
                              Text(
                                '取り直す',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          )
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}