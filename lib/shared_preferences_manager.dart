class SharedPreferencesManager {
  static final SharedPreferencesManager _instance = SharedPreferencesManager._internal();

  factory SharedPreferencesManager() {
      return _instance;
  }

  SharedPreferencesManager._internal();
}