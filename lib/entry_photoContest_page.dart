import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yuwaku_proto/goal_listview_cell.dart';
import 'package:yuwaku_proto/homepage_component/homePage_Item.dart';
import 'package:flutter/cupertino.dart';
import 'package:yuwaku_proto/shared_preferences_manager.dart';
import 'take_spot_notifier.dart';
import 'goal.dart';
import 'drawer_layout.dart';
import 'external_website.dart';

class PhotoContestEntry extends StatefulWidget {

  @override
  State<PhotoContestEntry> createState() => _PhotoContestEntryState();

}

class _PhotoContestEntryState extends State<PhotoContestEntry> {

  Map<String, String> _photoContestExplain = {
    'test1': '艦これ',
    'test2': 'アズレン',
    'test3': '艦これ1',
    'test4': 'アズレン2',
    'test5': '艦これ3',
    'test5': 'アズレン4',
  };

  int _counter = 0;


  @override
  Widget build(BuildContext context) {
    final listJmp = _photoContestExplain.entries
        .map((e) => PhotoContestExplain(e.key, e.value)).toList();

    for (int i = 0; i < listJmp.length; i++) {
      print(listJmp[i].title);
      print(listJmp[i].explain);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('写真コンテスト', style: TextStyle(color: Colors.white)),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: ListTile(
              title: _textWidget(listJmp, index, _counter, 'title'),
              subtitle: _textWidget(listJmp, index, _counter, 'explain'),
            ),
          );
        },
        itemCount: _photoContestExplain.length,
      ),
    );
  }
}

class PhotoContestExplain {
  String title;
  String explain;

  PhotoContestExplain(this.title, this.explain);
}

Widget _textWidget(List list, int index, int counter, String key) {
  if (key == 'title') {
    return Text(
      list[index].title,
    );
  }
  if (key == 'explain') {
    return Text(
      list[index].explain,
    );
  } else {
    return Text('nothing');
  }
}


