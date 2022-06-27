import 'package:flutter/material.dart';

class DistanceGoalNotifier extends ChangeNotifier {

  var distanceHimurogoya;

  void notifyDistanceHimurogoya(int distance) {
    distanceHimurogoya = distance;
    notifyListeners();
  }
}