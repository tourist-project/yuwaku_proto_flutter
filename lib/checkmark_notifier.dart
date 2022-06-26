import 'package:flutter/material.dart';

class CheckmarkNotifier extends ChangeNotifier {

  var isTakedHimurogoya = false;

  void notifyTakedHimurogoya() {
    isTakedHimurogoya = true;
    notifyListeners();
  }
}