import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_launcher_icons/main.dart';
import 'package:geolocator/geolocator.dart';
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
    var Height = MediaQuery.of(context).size.height;
    var Width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              height: Height,
              width: Width,
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
            Align(
              alignment: const Alignment(0, 0.9),
              child: GestureDetector(
                onTap: () async {
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
                child: Container( 
                  width: Width / 4,
                  height: Height / 7,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 8),
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Icon(Icons.photo_camera_outlined, size: Height / 20),
                ),
              ),
            )
          ],
        ) 
      ),
    );
  }
}
