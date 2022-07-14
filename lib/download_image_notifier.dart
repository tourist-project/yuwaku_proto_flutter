import 'package:flutter/material.dart';

class DownloadImageNotifier extends ChangeNotifier {

  String? himurogoyaImageUrl;
  String? yumejikanImageUrl;
  String? soyuImageUrl;
  String? ashiyuImageUrl;
  String? yakushijiImageUrl;

  void notifyDownloadHimurogoyaImage(String? url) {
    himurogoyaImageUrl = url;
    notifyListeners();
  }

  void notifyDownloadYumejikanImage(String? url) {
    yumejikanImageUrl = url;
    notifyListeners();
  }

  void notifyDownloadSoyuImage(String? url) {
    soyuImageUrl = url;
    notifyListeners();
  }

  void notifyDownloadAshiyuImage(String? url) {
    ashiyuImageUrl = url;
    notifyListeners();
  }

  void notifyDownloadYakushijiImage(String? url) {
    yakushijiImageUrl = url;
    notifyListeners();
  }
}