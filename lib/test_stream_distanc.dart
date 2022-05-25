import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yuwaku_proto/ditance_calcuation.dart';
import 'package:yuwaku_proto/map_page.dart';
import 'dart:async';
import 'package:yuwaku_proto/map_painter.dart';
import 'map_painter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:ui' as ui;
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

class StreamShow extends StatefulWidget {

  StreamShow({Key? key}) : super(key: key);

  @override
  _StreamShow createState() => _StreamShow();
}

class _StreamShow extends State<StreamShow> {

  var distanceStream = StreamController<Position>();
  var stringStream = StreamController<String>();
  var doubleStream = StreamController<double>();
  DistanceItemsStream taker = new DistanceItemsStream();
  TransStringDistance convertor = new TransStringDistance();

  @override
  void initState() {
    taker.init(distanceStream);
    convertor.init(doubleStream, stringStream);
    taker.getStream();
    convertor.convertToString();
    super.initState();
  }

  @override
  void dispose(){
    distanceStream.close();
    stringStream.close();
    doubleStream.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        stream: convertor.stringStream,
        initialData: " ",
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done){
            print(snapshot.data);
            return
              Flexible(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  child: Text(
                       snapshot.data!+ 'm',
                      style: TextStyle(fontSize: 4),
                      textAlign: TextAlign.left),
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




class DistanceItemsStream {

  var posStream;

  final mapItems = <DistanceItems>[
    DistanceItems('総湯',
        36.485425901995455, 136.75758738535384
    ),
    DistanceItems('氷室',
      36.48346516395541, 136.75701193508996,
    ),
    DistanceItems('足湯(立派な方)',
      36.48582537854954, 136.7574341842218,
    ),
    DistanceItems('みどりの里',
        36.49050881078798, 136.75404574490975
    ),
    DistanceItems('湯涌夢二館',
        36.48584951599308, 136.75738876226737
    ),
  ];


  init(StreamController<Position> stream) {
    posStream = stream;
  }

  getStream() async {
    MapPainter.determinePosition()
        .then((event) {
      Geolocator.getPositionStream(
        intervalDuration: Duration(seconds: 5),
        desiredAccuracy: LocationAccuracy.best,
      ).listen((location) {
        for (DistanceItems item in mapItems) {
          item.setDistance(location);// 距離関係を更新する
          print('あああああああああああ${item.distance}');
          posStream.sink.add(item.distance);
        }
      });
    });
  }
}

class TransStringDistance{
  var doubleStream;
  var stringStream;

  init(StreamController<double> doubleStream,
      StreamController<String> strStream){
    this.doubleStream = doubleStream;
    this.stringStream = strStream;
  }

  convertToString(){
    doubleStream.stream.listen((data) async{
      String newData = data.toStringAsFixed(2);
      stringStream.sink.add(newData);
    });
  }
}

