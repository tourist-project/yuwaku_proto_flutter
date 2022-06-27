import 'package:flutter/material.dart';

class CheckmarkImage extends StatelessWidget {

  @override
  var isCheck;
  CheckmarkImage(this.isCheck);
  Widget build(BuildContext context) {
    final double mediaWidth = MediaQuery.of(context).size.width;
    if (isCheck) {
      return Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.check_box_outline_blank_rounded,
            color: Colors.black38,
            size: mediaWidth/4,
          ),
          Image.asset('assets/images/checkMark.png')
        ],
      );
    } else {
      return Center(
        child: Icon(
          Icons.check_box_outline_blank_rounded,
          color: Colors.black38,
          size: mediaWidth/4,
        ),
      );
    }
  }
}