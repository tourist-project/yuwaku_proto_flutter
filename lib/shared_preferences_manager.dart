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
        break;
      case Goal.soyu:
        break;
      case Goal.ashiyu:
        break;
      case Goal.yakushiji:
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
        break;
      case Goal.soyu:
        break;
      case Goal.ashiyu:
        break;
      case Goal.yakushiji:
        break;
    }
  }
}