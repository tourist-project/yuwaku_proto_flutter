import 'package:flutter/material.dart';

class CheckmarkImage extends StatelessWidget {

  @override
  var isCheck;
  CheckmarkImage(this.isCheck);
  Widget build(BuildContext context) {
    if (isCheck) {
      return Image.asset('assets/images/checkMark.png');
    } else {
      return Container();
    }
  }
}