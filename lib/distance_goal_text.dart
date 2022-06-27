import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_size_text/auto_size_text.dart';

class DistanceGoalText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Container(
            margin: EdgeInsets.only(right: 5, left: 5),
            child: AutoSizeText(
              '目的地まで',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Center(
            child: AutoSizeText(
              'あと' + '20' + 'm',
              style: TextStyle(fontSize:  18),
            ),
          ),
        ]
    );
  }
}