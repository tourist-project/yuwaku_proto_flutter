import 'package:flutter/material.dart';

class TutorialPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TutorialPageState();
  }
}

class _TutorialPageState extends State<TutorialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("title"),
      ),
    );
  }
}