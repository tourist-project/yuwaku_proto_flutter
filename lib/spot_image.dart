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
        _imagePath = 'assets/images/HimuroGoya/HimurogoyaGray.jpg';
        break;
      case Goal.yumejikan:
        _imagePath = 'assets/images/Yumezikan/YumejikanGray.jpg';
        break;
      case Goal.soyu:
        _imagePath = 'assets/images/Soyu/SoyuGray.jpeg';
        break;
      case Goal.ashiyu:
        _imagePath = 'assets/images/Ashiyu/AsiyuGray.jpg';
        break;
      case Goal.yakushiji:
        _imagePath = 'assets/images/YakushijiGray.jpg';
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
                color: Color(0xffD9D9D9),
                child: Image(
                  image: MemoryImage(File(snapshot.data!).readAsBytesSync()),
                ),
              );
            } else {
              return Container(
                width: double.infinity,
                height: 200,
                color: Colors.grey,
                child: Image(
                  fit: BoxFit.cover,
                  image: AssetImage(_imagePath),
                ),
              );
            }
          }
        ),
      ],
    );
  }
}