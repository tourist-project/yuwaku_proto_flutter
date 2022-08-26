import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart';
import 'package:yuwaku_proto/map_component/map_interactive_move.dart';
import 'package:yuwaku_proto/some_top_page.dart';
import 'package:yuwaku_proto/tutorial_page.dart';


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
         InteractiveMap(title: '湯涌全体図')
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
          BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: '地図'),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.amber[700],
        onTap: _onItemTapped,
        backgroundColor: Colors.white12,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  void _onItemTapped(int index) => setState(() => _currentIndex = index );
}