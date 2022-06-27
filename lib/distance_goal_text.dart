import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:geolocator/geolocator.dart';
import 'package:yuwaku_proto/map_component/map_painter.dart';

class DistanceGoalText extends StatefulWidget {
  const DistanceGoalText({Key? key}) : super(key: key);

  @override
  State<DistanceGoalText> createState() => _DistanceGoalText();
}

class _DistanceGoalText extends State<DistanceGoalText> {

  double latitude = 36.48346516395541;
  double longitude = 136.75701193508996;
  double? distance;

  void setDistance(Position position) {
    this.distance = Geolocator.distanceBetween(
        position.latitude, position.longitude, this.latitude, this.longitude);
  }

  Stream<Position> _getDistance() async* {
    MapPainter.determinePosition().then((_) {
      Geolocator.getPositionStream(
        intervalDuration: Duration(seconds: 5),
        desiredAccuracy: LocationAccuracy.best,
      ).listen((location) {
        setState(() {
          setDistance(location);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Position>(
        stream: _getDistance(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(children: [
              Container(
                margin: EdgeInsets.only(right: 5, left: 5),
                child: AutoSizeText(
                  '目的地まで',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Center(
                child: AutoSizeText(
                  'あと' + '${distance}' + 'm',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ]);
          } else {
            return Container();
          }
        });
  }
}