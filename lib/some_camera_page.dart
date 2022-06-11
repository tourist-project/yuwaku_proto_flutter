import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class Camerapage extends StatefulWidget{
  Camerapage({Key? key, required this.camera}) : super(key: key);
  final CameraDescription camera;

  @override
  _Camerapage createState() => _Camerapage(camera: this.camera);
}

class _Camerapage extends State<Camerapage>{
  _Camerapage({Key? key,required this.camera});
  
  final CameraDescription camera;
  
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.high,
    );
    _initializeControllerFuture = _controller.initialize();
  }
  @override
  void dispose() {
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
          // 表示用の画面に遷移
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DisplayPictureScreen(imagePath: image.path,camera: camera),
              fullscreenDialog: true,
            ),
            );
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}

// 撮影した写真を表示する画面
class DisplayPictureScreen extends StatelessWidget {
  DisplayPictureScreen({Key? key, required this.imagePath,required this.camera})
      : super(key: key);

  final String imagePath;
  final CameraDescription camera;
  final storage = FirebaseStorage.instance;

  void uploadStorage() {
    final ref = storage.ref();
    final imageFile = File(imagePath);
    var uuid = Uuid().v1();
    ref.child(uuid).putFile(imageFile);
  }

  Future _saveImage() async {
    final imageFile = File(imagePath);
    final imageBuffer = await imageFile.readAsBytes();
    await ImageGallerySaver.saveImage(imageBuffer);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('撮れた写真')),
      body: Center(child: Image.file(File(imagePath))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          uploadStorage();
          _saveImage();
          int count = 0;
          Navigator.of(context).popUntil((route) => count++ >= 2);
        },
        child: Icon(Icons.download),
      ),
    );
  }
}
