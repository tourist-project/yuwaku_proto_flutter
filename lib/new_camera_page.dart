import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:yuwaku_proto/some_top_page.dart';
import 'package:camera/camera.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import 'package:yuwaku_proto/take_spot_notifier.dart';
import 'package:yuwaku_proto/goal.dart';
import 'package:yuwaku_proto/shared_preferences_manager.dart';
import 'package:flutter/services.dart';
import 'documents_directory_client.dart';

class NewCameraPage extends StatefulWidget {
  const NewCameraPage({Key? key, required this.camera, required this.goal}): super(key: key);
  
  final Goal goal;
  final CameraDescription camera;

  @override
  _NewCameraPage createState() => _NewCameraPage(camera: camera, goal: this.goal);
}

class _NewCameraPage extends State<NewCameraPage> {
  
  _NewCameraPage({Key? key, required this.camera, required this.goal});
  
  final CameraDescription camera;
  final Goal goal;
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.high,
    );
    
    _initializeControllerFuture = _controller.initialize();
    
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    // ウィジェットが破棄されたら、コントローラーを破棄
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return CameraPreview(_controller);
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // 写真を撮る
          final image = await _controller.takePicture();
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
          ]);
          // 表示用の画面に遷移
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DisplayPictureScreen(imagePath: image.path,camera: camera, goal: goal),
              fullscreenDialog: true,
            ),
          );
        },
        child: const Icon(Icons.photo_camera_outlined),
      ),
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  DisplayPictureScreen({
    Key? key,
    required this.imagePath,
    required this.camera,
    required this.goal
  }) : super(key: key);

  final String imagePath;
  final CameraDescription camera;
  final storage = FirebaseStorage.instance;
  final Goal goal;
  final _sharedPreferencesManager = SharedPreferencesManager();
  final _documentsDirectoryClient = DocumentsDirectoryClient();

  Future<void> _saveImageToDocumentsDirectory(String path, Goal goal) async {
    File savedImagePath = await _documentsDirectoryClient.saveImage(goal, path);
    await _sharedPreferencesManager.setImageStoragePath(
      goal, savedImagePath.path
    );
  }

  void showNoPermissionDialog(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: (_) {
        return NoPermissionDialog();
      }
    );
  }

  void popToHome(BuildContext context) async {
    int count = 0;
    Navigator.of(context).popUntil((route) => count++ >= 2);
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
              child: Image.file(File(imagePath), fit: BoxFit.cover),
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
                            onTap: () async {
                              await _saveImageToDocumentsDirectory(
                              imagePath, goal);
                              _checkNotify(context, goal);
                              popToHome(context);
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
                                  Icon(
                                    Icons.approval,
                                    color: Colors.white,
                                    size: MediaQuery.of(context).size.width / 13
                                  ),
                                  Text(
                                    '押す',
                                    style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.width / 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                    ),
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
                                  Icon(Icons.refresh, color: Colors.white, size: MediaQuery.of(context).size.width / 13),
                                  Text(
                                    'やり直す',
                                    style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.width / 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                    ),
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

class NoPermissionDialog extends StatelessWidget {
  const NoPermissionDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('写真の保存を許可してください'),
      actions: [
        TextButton(
            child: Text("戻る"),
            onPressed: () {
              int count = 0;
              Navigator.of(context).popUntil((route) => count++ >= 3);
            }),
      ],
    );
  }
}
