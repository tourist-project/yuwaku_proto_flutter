import 'package:flutter/material.dart';
import 'package:yuwaku_proto/tutorial_page.dart';
import 'map_page.dart';
import 'package:yuwaku_proto/app_top_view.dart';
import 'plane_explain.dart';

class BottomTabPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BottomTabPageState();
  }
}

class _BottomTabPageState extends State<BottomTabPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          TopPageView(selectItem: (index) => _onItemTapped(index)),
          MapPage(title: '地図'),
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
                Icons.add_location_alt_sharp,
              ),
              label: '地図'),
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