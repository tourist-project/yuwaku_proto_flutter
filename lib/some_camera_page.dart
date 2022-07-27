import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:yuwaku_proto/checkmark_notifier.dart';
import 'package:yuwaku_proto/download_image_notifier.dart';
import 'package:yuwaku_proto/goal.dart';
import 'package:yuwaku_proto/shared_preferences_manager.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:flutter/services.dart';
import 'formatted_date_manager.dart';

class Camerapage extends StatefulWidget{
  Camerapage(
      {
        Key? key,
        required this.camera,
        required this.goal,
      }
      ) : super(key: key);
  final CameraDescription camera;
  final Goal goal;

  @override
  _Camerapage createState() => _Camerapage(camera: this.camera, goal: this.goal);
}

class _Camerapage extends State<Camerapage>{
  _Camerapage({Key? key,required this.camera, required this.goal});
  
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

// 撮影した写真を表示する画面
class DisplayPictureScreen extends StatelessWidget {
  DisplayPictureScreen(
      {
        Key? key,
        required this.imagePath,
        required this.camera,
        required this.goal
      }
      ) : super(key: key);

  final String imagePath;
  final CameraDescription camera;
  final storage = FirebaseStorage.instance;
  final Goal goal;
  final sharedPreferencesManager = SharedPreferencesManager();
  final _formattedDateManager = FormattedDateManager();

  Future<TaskSnapshot> _uploadStorage() async {
    final uploadDateString = _formattedDateManager.stringSlashedFormatDate();
    final ref = storage.ref();
    final imageFile = File(imagePath);
    var uuid = Uuid().v1();
    final imageRef = ref.child(uploadDateString).child(uuid);
    final uploadTask = await imageRef.putFile(imageFile);
    return uploadTask;
  }

  Future<String?> _downloadImage(TaskSnapshot task) async {
    if (task.state == TaskState.success) {
      final imageRef = task.ref;
      return imageRef.getDownloadURL();
    }
    return null;
  }

  void _saveImage(String path) async {
    File roatedImage = await FlutterExifRotation.rotateImage(path: path);
    final Uint8List imageBuffer = await roatedImage.readAsBytes();
    await ImageGallerySaver.saveImage(imageBuffer);
  }

  void showNoPermissionDialog(BuildContext context) async {
    await showDialog<void>(
        context: context,
        builder: (_) {
          return NoPermissionDialog();
        });
  }

  void popToHome(BuildContext context) async {
    int count = 0;
    Navigator.of(context).popUntil((route) => count++ >= 2);
  }

  void _checkNotify(BuildContext context, Goal goal) {
    sharedPreferencesManager.setIsTook(goal);
    switch (goal) {
      case Goal.himurogoya:
        context.read<CheckmarkNotifier>().notifyTakedHimurogoya();
        break;
      case Goal.yumejikan:
        context.read<CheckmarkNotifier>().notifyTakedYumejikan();
        break;
      case Goal.soyu:
        context.read<CheckmarkNotifier>().notifyTakedSoyu();
        break;
      case Goal.ashiyu:
        context.read<CheckmarkNotifier>().notifyTakedAshiyu();
        break;
      case Goal.yakushiji:
        context.read<CheckmarkNotifier>().notifyTakedYakushiji();
        break;
    }
  }

  void _downloadNotify(BuildContext context, Goal goal, String? url) {
    if (url == null) {
      return;
    }
    sharedPreferencesManager.setDownloadUrl(goal, url);
    switch (goal) {
      case Goal.himurogoya:
        context.read<DownloadImageNotifier>().notifyDownloadHimurogoyaImage(url);
        break;
      case Goal.yumejikan:
        context.read<DownloadImageNotifier>().notifyDownloadYumejikanImage(url);
        break;
      case Goal.soyu:
        context.read<DownloadImageNotifier>().notifyDownloadSoyuImage(url);
        break;
      case Goal.ashiyu:
        context.read<DownloadImageNotifier>().notifyDownloadAshiyuImage(url);
        break;
      case Goal.yakushiji:
        context.read<DownloadImageNotifier>().notifyDownloadYakushijiImage(url);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('撮れた写真')),
      body: Center(child: Image.file(File(imagePath))),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _checkNotify(context, goal);
          _saveImage(imagePath);
          final task = await _uploadStorage();
          final url = await _downloadImage(task);
          _downloadNotify(context, goal, url);
          popToHome(context);
        },
        child: Icon(Icons.download),
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
          }
        ),
      ],
    );
  }
}
