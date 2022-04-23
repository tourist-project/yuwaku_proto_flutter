import 'package:shared_preferences/shared_preferences.dart';

class DatabaseClient {

  void insertImageData(String spot, imagePath) async {
    print("写真の保存に成功しました");
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(spot, imagePath);
  }

   Future<String> getImageData(String spot) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(spot) ?? "";
  }
}
