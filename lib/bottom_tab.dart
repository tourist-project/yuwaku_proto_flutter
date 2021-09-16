import 'package:flutter/material.dart';
import 'map_page.dart';
import 'some_explain.dart';

class BottomTabPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BottomTabPageState();
  }
}

class _BottomTabPageState extends State<BottomTabPage> {

  int _currentIndex = 0;

  // ページの種類
  final _pageWidgets = [
    Explain(title: '場所説明'),
    MapPage(title: '地図'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageWidgets.elementAt(_currentIndex),

      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.add_comment_sharp),
            title: Text(''),),
          BottomNavigationBarItem(icon: Icon(Icons.add_location_alt_sharp),
              title: Text('')),
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