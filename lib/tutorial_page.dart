import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix;
import 'package:yuwaku_proto/tutorial_step_page.dart';

class TutorialPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TutorialPageState();
  }
}

class _TutorialPageState extends State<TutorialPage> {
  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(initialPage: 0);

    return Scaffold(
      appBar: AppBar(
        title: Text("使い方ガイド",
            style: TextStyle(color: prefix.Colors.black87)
        ),
      ),
      body: Center(
        child: PageView(
          scrollDirection: Axis.horizontal,
          controller: controller,
          children: <Widget>[
            Center(
              child: TutorialStepPage(
                  '観光スポットを探索',
                  '画像とヒントを頼りに観光スポットを探そう！！',
                  'assets/images/tutorial_image_step1.png'
              ),
            ),
            Center(
              child: Text('Second Page'),
            ),
            Center(
              child: Text('Third Page'),
            )
          ],
        ),
      ),
    );
  }
}