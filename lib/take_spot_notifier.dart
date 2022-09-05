import 'package:flutter/material.dart';

class TakeSpotNotifier extends ChangeNotifier {

  var isTakedHimurogoya = false;
  var isTakedYumejikan = false;
  var isTakedSoyu = false;
  var isTakedAshiyu = false;
  var isTakedYakushiji = false;

  void notifyTakedHimurogoya() {
    isTakedHimurogoya = true;
    notifyListeners();
  }

  void notifyTakedYumejikan() {
    isTakedYumejikan = true;
    notifyListeners();
  }

  void notifyTakedSoyu() {
    isTakedSoyu = true;
    notifyListeners();
  }

  void notifyTakedAshiyu() {
    isTakedAshiyu = true;
    notifyListeners();
  }

  void notifyTakedYakushiji() {
    isTakedYakushiji = true;
    notifyListeners();
  }
}