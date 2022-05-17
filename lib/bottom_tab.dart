import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:yuwaku_proto/camera_page.dart';
import 'package:yuwaku_proto/homepage_component/homePage_screen.dart';
import 'package:yuwaku_proto/some_top_page.dart';
import 'package:yuwaku_proto/tutorial_page.dart';
import 'map_page.dart';
import 'some_explain.dart';
import 'package:yuwaku_proto/app_top_view.dart';
import 'plane_explain.dart';

class BottomTabPage extends StatefulWidget {
  
  BottomTabPage({Key? key, required this.camera});
  final CameraDescription camera;
  @override
  State<StatefulWidget> createState() {
    return _BottomTabPageState(camera: camera);
  }
}

class _BottomTabPageState extends State<BottomTabPage> {
  int _currentIndex = 0;
  _BottomTabPageState({Key? key, required this.camera});
  final CameraDescription camera;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          RunTopPage(camera: camera),
          TutorialPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_comment_sharp,
            ),
            label: 'ホーム',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.help,
              ),
              label: '遊び方'),
        ],
        currentIndex: _currentIndex,
        fixedColor: Colors.blueAccent,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  void _onItemTapped(int index) => setState(() => _currentIndex = index );
}