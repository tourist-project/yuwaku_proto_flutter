import 'dart:io';
import 'package:flutter/material.dart';
import 'package:yuwaku_proto/hint_dialog.dart';
import 'package:yuwaku_proto/shared_preferences_manager.dart';
import 'documents_directory_client.dart';
import 'goal.dart';

class SpotImage extends StatelessWidget {

  Goal goal;
  SpotImage(this.goal);
  final documentsDirectoryClient = DocumentsDirectoryClient();
  final _sharedPreferencesManager = SharedPreferencesManager();
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
        _imagePath = 'assets/images/Yakushizi1.png';
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

  @override
  Widget build(BuildContext context) {
    getImagePath(goal);
    return Stack(
      children: [
        FutureBuilder(
          future: _sharedPreferencesManager.getImageStoragePath(goal),
          builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return Container(
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
                    image: MemoryImage(File(snapshot.data!).readAsBytesSync()),
                  ),
                ),
              );
            } else {
              return Container(
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
                    image: AssetImage(_imagePath),
                  ),
                ),
              );
            }
          }
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