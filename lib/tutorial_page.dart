import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix;

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
          children: const <Widget>[
            Center(
              child: Text('First Page'),
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