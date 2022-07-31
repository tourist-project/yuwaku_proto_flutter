import 'package:flutter/material.dart';
import 'package:yuwaku_proto/hint_dialog.dart';
import 'package:yuwaku_proto/shared_preferences_manager.dart';
import 'goal.dart';

class SpotImage extends StatelessWidget {

  Goal goal;
  String? downloadImageUrl;
  SpotImage(this.goal, this.downloadImageUrl);

  final sharedPreferencesManager = SharedPreferencesManager();
  late String _imagePath;

  void getImagePath(Goal goal) {
    switch (goal) {
      case Goal.himurogoya:
        _imagePath = 'assets/images/HimuroGoya/HimuroGoya.png';
        break;
      case Goal.yumejikan:
        _imagePath = 'assets/images/Yumezikan/Yumezikan.png';
        break;
      case Goal.soyu:
        _imagePath = 'assets/images/Soyu/KeigoSirayu.png';
        break;
      case Goal.ashiyu:
        _imagePath = 'assets/images/Ashiyu/Asiyu(temp).png';
        break;
      case Goal.yakushiji:
        _imagePath = 'assets/images/Yakushizi/Yakushizi1.png';
        break;
    }
  }

  void showHintDialog(BuildContext context) async {
    await showDialog<void>(
        context: context,
        builder: (_) {
          return HintDialog(goal);
        });
  }

 ImageProvider setImage(String? url) {
    if (url != null) {
      return NetworkImage(url);
    }
    return AssetImage(_imagePath);
  }

  @override
  Widget build(BuildContext context) {
    getImagePath(goal);
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.black,
                  spreadRadius: 3,
                  blurRadius: 3,
                  offset: Offset(0, 3))
            ],
            image: DecorationImage(
              fit: BoxFit.cover,
              image: setImage(downloadImageUrl),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: ElevatedButton(onPressed: () {
            showHintDialog(context);
          },
            child: Icon(Icons.lightbulb, color: Colors.orange.shade600,),
            style: ElevatedButton.styleFrom(
              primary: Color.fromRGBO(240, 233, 208, 40),
              minimumSize: Size(40, 40),
              shape: CircleBorder(),
            ),
          ),
        ),
      ],
    );
  }
}