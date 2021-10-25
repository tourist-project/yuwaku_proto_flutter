import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'main.dart';
import 'plane_explain.dart';


class DevelopmentPage extends StatefulWidget{

  DevelopmentPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _DevelopmentPage createState() => _DevelopmentPage();

}


class _DevelopmentPage extends State<DevelopmentPage> with TickerProviderStateMixin {

  static const String title = '開発中';
  var _animationController;
  var _animtaion;

  @override
  void initState() {
    _animationController = AnimationController(
        duration: Duration(milliseconds: 300),vsync: this);
    _animtaion = Tween(begin: 0.0, end: 1.0).animate(_animationController);

    super.initState();
  }

  @override
  void dispose(){
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: TextStyle(color: Colors.black87)),
      ),
      body: Container(

            width: 200,
            height: 200,
            color: Colors.red,

      ),
    );
  }
}

