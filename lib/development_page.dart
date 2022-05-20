import 'dart:ui';
import 'package:flutter/material.dart';


class DevelopmentPage extends StatefulWidget {
  DevelopmentPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _DevelopmentPage createState() => _DevelopmentPage();
}

class _DevelopmentPage extends State<DevelopmentPage> with TickerProviderStateMixin {
  static const String title = '開発中';
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);

    _animationController.forward(from: 0.0);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: TextStyle(color: Colors.black87)),
      ),
      body: buildAnimation(),
    );
  }

  Widget buildAnimation() {
    final animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastOutSlowIn,
    ));

    final Size mediaSize = MediaQuery.of(context).size; // 画面の取得

    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget? child) {
        return Container(
          alignment: Alignment.center,
          width: mediaSize.width,
          height: mediaSize.height,
          child: FadeTransition(
            opacity: animation,
            child: Transform(
              transform: _generateMatrix(animation),
              child: Container(
                child: RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyText1,
                    children: [
                      TextSpan(text: '開発中です', style: TextStyle(fontSize: 36)),
                      WidgetSpan(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: Icon(Icons.build_outlined),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // Translateする時の値を行列で返す
  Matrix4 _generateMatrix(Animation animation) {
    final value = lerpDouble(50.0, 0, animation.value);
    return Matrix4.translationValues(0.0, value!, 0.0);
  }
}
