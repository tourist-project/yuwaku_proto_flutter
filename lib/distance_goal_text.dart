import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:geolocator/geolocator.dart';
import 'package:yuwaku_proto/goal.dart';
import 'package:yuwaku_proto/map_component/map_painter.dart';

class DistanceGoalText extends StatefulWidget {
  const DistanceGoalText(this.goal);
  final goal;

  @override
  State<DistanceGoalText> createState() => _DistanceGoalText();
}

class _DistanceGoalText extends State<DistanceGoalText> {

  double latitude = 0.0;
  double longitude = 0.0;
  double? distance;

  void setDistance(Position position) {
    this.distance = Geolocator.distanceBetween(
        position.latitude, position.longitude, this.latitude, this.longitude);
  }

  void switchDistance(Goal goal) {
    switch (goal) {
      case Goal.himurogoya:
        latitude = 36.48346516395541;
        longitude = 136.75701193508996;
        break;
      case Goal.yumejikan:
        latitude = 36.48584951599308;
        longitude = 136.75738876226737;
        break;
      case Goal.soyu:
        latitude = 36.485425901995455;
        longitude = 136.75758738535384;
        break;
      case Goal.ashiyu:
        latitude = 36.48582537854954;
        longitude = 136.7574341842218;
        break;
      case Goal.yakushiji:
        latitude = 36.48566;
        longitude = 136.75794;
        break;
    }
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
    switchDistance(widget.goal);
    return StreamBuilder<Position>(
        stream: _getDistance(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: AutoSizeText(
                distance != null ?
                'あと' + distance!.toStringAsFixed(0) + 'm':
                "Loading",
                style: TextStyle(fontSize: 24),
              ),
            );
          } else {
            return Container();
          }
        });
  }
}