import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:yuwaku_proto/display_picture_page.dart';
import 'package:yuwaku_proto/goal.dart';
import 'package:flutter/services.dart';

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
  _Camerapage   createState() => _Camerapage(camera: this.camera, goal: this.goal);
}

class _Camerapage    extends State<Camerapage>{
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
    _initializeControllerFuture= _controller.initialize();
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
              builder: (context) => DisplayPicturePage(imagePath: image.path,camera: camera, goal: goal),
              fullscreenDialog: true,
            ),
            );
        },
        child: const Icon(Icons.photo_camera_outlined),
      ),
    );
  }
}
