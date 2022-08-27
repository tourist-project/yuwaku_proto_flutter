import 'dart:io';
import 'package:flutter/material.dart';
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
                width: double.infinity,
                height: 220,
                color: Colors.grey,
                child: Image(
                  image: MemoryImage(File(snapshot.data!).readAsBytesSync()),
                ),
              );
            } else {
              return Container(
                width: double.infinity,
                height: 200,
                color: Colors.grey,
              );
            }
          }
        ),
      ],
    );
  }
}