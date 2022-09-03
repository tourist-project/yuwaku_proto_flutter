import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:yuwaku_proto/some_top_page.dart';
import 'package:yuwaku_proto/tutorial_page.dart';

import 'map_component/map_interactive_move.dart';

class BottomBar extends StatefulWidget {
  BottomBar({Key? key, required this.camera});

  final CameraDescription camera;
  @override
  State<StatefulWidget> createState() {
    return _BottomBarState(camera: camera);
  }
}

class _BottomBarState extends State<BottomBar> {
  _BottomBarState({required this.camera});
  final CameraDescription camera;
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          RunTopPage(camera: camera),
          TutorialPage(),
          InteractiveMap(title: '湯涌全体図')
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.amber[700],
        backgroundColor: Color(0xfff9cb9a),
        currentIndex: _selectedIndex,
        items: [
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
              label: '遊び方'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: '地図'
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) => setState(() => _selectedIndex = index );
}