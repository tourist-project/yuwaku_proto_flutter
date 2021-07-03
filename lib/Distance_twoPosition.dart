import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math';
import 'package:angles/angles.dart';

class Distance {

  late double lat1;
  late double lon1;
  late double lat2;
  late double lon2;

  Future<void> getLocation() async {

    // 現在の位置を返す
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // 北緯がプラス。南緯がマイナス
    print("緯度: " + position.latitude.toString());
    lat1 = position.latitude;
    // 東経がプラス、西経がマイナス
    print("経度: " + position.longitude.toString());
    lon1 = position.longitude;

    print(
      // 単位はメートル
      CalculateDisntance(lat1, lon1, 36.4859822, 136.7560359).toString()
    );



    /// 直線距離を計測(公式ライブラリを使用)
    double distanceMeters = Geolocator.distanceBetween(position.latitude, position.longitude,
        36.4859822, 136.7560359);
    print('======================================');
    // 単位はメートル
    print(distanceMeters);
  }

}

/// 直線距離距離を計測(ヒュベニの公式を利用)
double CalculateDisntance(double lat1, double lon1, double lat2, double lon2){

  // 緯度経度をラジアンに変換
  double radLat1 = lat1*(pi/180);
  double radLon1 = lon1*(pi/180);
  double radLat2 = lat2*(pi/180);
  double radLon2 = lon2*(pi/180);

  // 緯度差
  double radratDiff = (radLat1 - radLat2);
  // 経度差
  double radlonDiff = (radLon1 - radLon2);
  // 平均緯度
  double radLatAverage = (radLat1 + radLat2);
  // 赤道半径
  double horizontal = 6377397.155;
  // 離心率の2乗
  double e2 = 0.00667436061028297;

  double sinLat = radLatAverage.sign;
  double w2 = 1.0 - e2 *(sinLat * sinLat);
  // 子午曲半径M
  double M = horizontal*(1-e2) / (sqrt(w2*w2*w2));
  // 卯酉線曲率半径
  double N = horizontal / (sqrt(w2));

  double t1 = M * radratDiff;
  double t2 = N * cos(radLatAverage) * radlonDiff;

  double dist = sqrt((t1*t1)+(t2*t2));
  return dist;
}
