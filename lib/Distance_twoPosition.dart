import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math';
import 'package:angles/angles.dart';
import 'dart:async';
import 'map_page.dart';


class Distance {

  Distance(this.latitude, this.longitude);

  double latitude;
  double longitude;
  late double distance;

  Future<double> getLocation() async {

    // 現在の位置を返す
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);

    distance = Geolocator.distanceBetween( /// 直線距離を計測(公式ライブラリを使用)
        position.latitude, position.longitude,
        36.4859822, 136.7560359);

    return distance;
  }

}
