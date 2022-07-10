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
}