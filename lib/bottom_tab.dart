import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yuwaku_proto/tutorial_page.dart';
import 'map_page.dart';
import 'package:yuwaku_proto/app_top_view.dart';

class BottomTabPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BottomTabPageState();
  }
}

class _BottomTabPageState extends State<BottomTabPage> {

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add_comment_sharp),
            activeIcon: Icon(Icons.add_comment_sharp,
              color: Colors.blue,
            ),
            label: "ホーム画面",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_location_alt_sharp),
              activeIcon: Icon(Icons.add_location_alt_sharp,
              color: Colors.blue,
              ),
              label: '地図'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.help),
              activeIcon: Icon(Icons.help,
              color: Colors.blue,
              ),
              label: '遊び方'
          ),
        ],
      ),
        tabBuilder: (BuildContext context, int index) {
        switch(index){
          case 0:
            return CupertinoTabView(builder: (context){
              return CupertinoPageScaffold(
                child: topPageView(),
              );
            }
            );
            case 1:
              return CupertinoTabView(builder: (context){
                return CupertinoPageScaffold(
                  child: MapPage(title: '地図'),
                );
              }
            );
              case 2:
                return CupertinoTabView(builder: (context){
                  return CupertinoPageScaffold(
                    child: TutorialPage(),
                  );
                }
                );
                default: return SizedBox.shrink(); // 何もない空のWidget←これがないとエラー出ます
        }
      }
    );
  }
}