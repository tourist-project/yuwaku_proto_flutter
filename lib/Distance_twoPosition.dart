import 'package:geolocator/geolocator.dart';
import 'dart:math';
import 'dart:async';
import 'package:bot_toast/bot_toast.dart';


class Distance {

  static Future<bool> checkPermission() async { // 位置情報利用許可
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      BotToast.showText(
          text: '位置情報の取得が有効ではありません。\n'
              '位置情報の取得を許可してください。');
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        BotToast.showText(
            text: '位置情報の取得が拒否されました。\n'
                '位置情報の取得を許可してください。');
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      BotToast.showText(
          text: '位置情報の取得が永久に拒否されています。\n'
              '位置情報の取得を許可してください。');
      return false;
    }
    return true;
  }

  static Stream<Position> streamCurrentPosition() =>
      Geolocator.getPositionStream(
        intervalDuration: const Duration(seconds: 5),
        desiredAccuracy: LocationAccuracy.best
      );

}
