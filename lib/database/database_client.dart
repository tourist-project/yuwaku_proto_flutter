import 'package:shared_preferences/shared_preferences.dart';

enum ImageSpot {
  himurogoya,
  kanazawaYumejikan,
  soyu,
  ashiyu,
  midorinosato
}

class DatabaseClient {

  void insertImageData(ImageSpot spot, imagePath) async {
    final prefs = await SharedPreferences.getInstance();

    switch (spot) {
      case ImageSpot.himurogoya:
        await prefs.setString('himurogoya', imagePath);
        break;
      case ImageSpot.kanazawaYumejikan:
        await prefs.setString('kanazawaYumejikan', imagePath);
        break;
      case ImageSpot.soyu:
        await prefs.setString('soyu', imagePath);
        break;
      case ImageSpot.ashiyu:
        await prefs.setString('ashiyu', imagePath);
        break;
      case ImageSpot.midorinosato:
        await prefs.setString('midorinosato', imagePath);
        break;
    }
  }
}
