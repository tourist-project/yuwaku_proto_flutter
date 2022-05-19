import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yuwaku_proto/map_page.dart';
import 'dart:async';
import 'package:yuwaku_proto/map_painter.dart';
import 'map_painter.dart';
import 'package:geolocator/geolocator.dart';
import 'homepage_component/homePage_Item.dart';

import 'package:auto_size_text/auto_size_text.dart';


class DistanceItems {
  final String name;
  final double latitude; // 緯度
  final double longitude; // 経度
  double? distance; // 距離

  DistanceItems(
      this.name,
      this.latitude,
      this.longitude,
      );

  // 距離を図る
  double setDistance(Position position) {
    return this.distance = Geolocator.distanceBetween(
        position.latitude, position.longitude, this.latitude, this.longitude);
  }
}

class ShowDistancePosition extends StatefulWidget {
  ShowDistancePosition({Key? key}) : super(key: key);

  @override
  _ShowDistancePosition createState() => _ShowDistancePosition();
}

class _ShowDistancePosition extends State<ShowDistancePosition> {

  late Stream<Position> _initializeStream;


  /*学校でテスト
  LC：36.5309848,136.6271052
  1号館：36.5309848,136.6271052
   */

  /// マップの場所情報の一覧
  final _mapItems = <DistanceItems>[
    /*MapItem('湯涌稲荷神社', 36.4856770,136.7582343, Offset(1254, 292),
        'assets/images/img1_gray.png', Rect.fromLTWH(650, 182, 280, 280)),*/
    DistanceItems('総湯',
        36.485425901995455, 136.75758738535384
    ),
    DistanceItems('氷室',
        36.48346516395541, 136.75701193508996,
    ),
    DistanceItems('足湯(立派な方)',
      36.48582537854954, 136.7574341842218,
    ),
    /* MapItem('足湯(湯の出)', 36.48919374904115, 136.75588850463596, Offset(505, 690),
        'assets/images/Asiyu(temp).png', Rect.fromLTWH(750, 80, 280, 280)),
        */
    DistanceItems('みどりの里',
      36.49050881078798, 136.75404574490975
    ),
    DistanceItems('湯涌夢二館',
        36.48584951599308, 136.75738876226737
    ),
  ];



  @override
  void initState() {
    super.initState();
    _initializeStream = _getStream();
  }

  Stream<Position> _getStream() async*{
    MapPainter.determinePosition()
        .then((_) {
      Geolocator.getPositionStream(
        intervalDuration: Duration(seconds: 5),
        desiredAccuracy: LocationAccuracy.best,
      ).listen((location) {
        for(final item in _mapItems)
          item.setDistance(location); // 距離関係を更新する
      });
    }).catchError((_) => _dialogLocationLicense());
  }

  @override
  void dispose() {
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Position>(
      stream: _initializeStream,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done){
          for(var itemDist in _mapItems)
            itemDist.distance != null ?
            Flexible(
              flex: 1,
              child: Container(
                width: double.infinity,
                child: Text(itemDist.distance.toString(),
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.left),
              ),
            ):
            Container(
              width: double.infinity,
              child: AutoSizeText(
                  'Not Found Distance'
              ),
            );
        }
        return CircularProgressIndicator();
      }
    );
  }

  /// 位置情報が拒否されている時、「位置情報を許可する」ダイアログを表示する
  Future<void> _dialogLocationLicense() async {
    var result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        if (Platform.isAndroid) {
          return AlertDialog(
            title: Text('位置情報を許可する'),
            content: Text('設定でアプリに位置情報を許可します。'),
            actions: <Widget>[
              TextButton(
                  child: Text('Cancel'),
                  onPressed: () => Navigator.of(context).pop(false)),
              TextButton(
                  child: Text('OK'),
                  onPressed: () => Navigator.of(context).pop(true)),
            ],
          );
        }

        // iOS側の動作
        return CupertinoAlertDialog(
          title: Text('位置情報を許可する'),
          content: Text('設定でアプリに位置情報を許可します。'),
          actions: <Widget>[
            CupertinoDialogAction(
                child: Text('Cancel'),
                isDestructiveAction: true,
                onPressed: () => Navigator.of(context).pop(false)),
            CupertinoDialogAction(
                child: Text('OK'),
                onPressed: () => Navigator.of(context).pop(true))
          ],
        );
      },
    );

    if (result == null) return; // unwrap
    if (result) await Geolocator.openAppSettings(); // 'OK'を選択した時、設定画面を開く
  }
}

