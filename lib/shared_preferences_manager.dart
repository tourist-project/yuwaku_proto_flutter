import 'package:shared_preferences/shared_preferences.dart';
import 'package:yuwaku_proto/goal.dart';

class SharedPreferencesManager {
  static final SharedPreferencesManager _instance = SharedPreferencesManager._internal();

  factory SharedPreferencesManager() {
    return _instance;
  }

  SharedPreferencesManager._internal();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void setIsTook(Goal goal) async {
    final SharedPreferences prefs = await _prefs;
    switch (goal) {
      case Goal.himurogoya:
        await prefs.setBool("isTookHimurogoya", true);
        break;
      case Goal.yumejikan:
        await prefs.setBool("isTookYumejikan", true);
        break;
      case Goal.soyu:
        await prefs.setBool("isTookSoyu", true);
        break;
      case Goal.ashiyu:
        await prefs.setBool("isTookAshiyu", true);
        break;
      case Goal.yakushiji:
        await prefs.setBool("isTookYakushiji", true);
        break;
    }
  }

  Future<bool?> getIsTook(Goal goal) async {
    final SharedPreferences prefs = await _prefs;
    switch (goal) {
      case Goal.himurogoya:
        bool? isTook = prefs.getBool('isTookHimurogoya');
        return isTook;
      case Goal.yumejikan:
        bool? isTook = prefs.getBool('isTookYumejikan');
        return isTook;
      case Goal.soyu:
        bool? isTook = prefs.getBool('isTookSoyu');
        return isTook;
      case Goal.ashiyu:
        bool? isTook = prefs.getBool('isTookAshiyu');
        return isTook;
      case Goal.yakushiji:
        bool? isTook = prefs.getBool('isTookYakushiji');
        return isTook;
    }
  }

  void setDownloadUrl(Goal goal, String url) async {
    final SharedPreferences prefs = await _prefs;
    switch (goal) {
      case Goal.himurogoya:
        await prefs.setString("downloadHimurogoyaImageUrl", url);
        break;
      case Goal.yumejikan:
        await prefs.setString("downloadYumejikanImageUrl", url);
        break;
      case Goal.soyu:
        await prefs.setString("downloadSoyuImageUrl", url);
        break;
      case Goal.ashiyu:
        await prefs.setString("downloadAshiyuImageUrl", url);
        break;
      case Goal.yakushiji:
        await prefs.setString("downloadYakushijiImageUrl", url);
        break;
    }
  }

  Future<String?> getDownloaUrl(Goal goal) async {
    final SharedPreferences prefs = await _prefs;
    switch (goal) {
      case Goal.himurogoya:
        String? url = prefs.getString('downloadHimurogoyaImageUrl');
        return url;
      case Goal.yumejikan:
        String? url = prefs.getString('downloadYumejikanImageUrl');
        return url;
      case Goal.soyu:
        String? url = prefs.getString('downloadSoyuImageUrl');
        return url;
      case Goal.ashiyu:
        String? url = prefs.getString('downloadAshiyuImageUrl');
        return url;
      case Goal.yakushiji:
        String? url = prefs.getString('downloadYakushijiImageUrl');
        return url;
    }
  }

  Future<void> setImageStoragePath(Goal goal, String path) async {
    final SharedPreferences prefs = await _prefs;
    switch (goal) {
      case Goal.himurogoya:
        await prefs.setString("himurogoyaImageStoragePath", path);
        break;
      case Goal.yumejikan:
        await prefs.setString("yumejikanImageStoragePath", path);
        break;
      case Goal.soyu:
        await prefs.setString("soyuImageStoragePath", path);
        break;
      case Goal.ashiyu:
        await prefs.setString("ashiyuImageStoragePath", path);
        break;
      case Goal.yakushiji:
        await prefs.setString("yakushijiImageStoragePath", path);
        break;
    }
  }

  Future<String?> getImageStoragePath(Goal goal) async {
    final SharedPreferences prefs = await _prefs;
    switch (goal) {
      case Goal.himurogoya:
        String? path = prefs.getString('himurogoyaImageStoragePath');
        return path;
      case Goal.yumejikan:
        String? path = prefs.getString('yumejikanImageStoragePath');
        return path;
      case Goal.soyu:
        String? path = prefs.getString('soyuImageStoragePath');
        return path;
      case Goal.ashiyu:
        String? path = prefs.getString('ashiyuImageStoragePath');
        return path;
      case Goal.yakushiji:
        String? path = prefs.getString('yakushijiImageStoragePath');
        return path;
    }
  }
}