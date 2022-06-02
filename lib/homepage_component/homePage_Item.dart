
import 'package:geolocator/geolocator.dart';


class HomePageItem{

  HomePageItem(
      this.title, this.eng_title, this.explain, this.image,
      this.latitude, this.longitude,
      ){
    print('インスタンスの生成');
  }

  String title , eng_title, explain, image;
  double latitude, longitude;
  double? distance;



  /// 距離を図る
  void setDistance(Position position) {
    this.distance = Geolocator.distanceBetween(
        position.latitude, position.longitude, this.latitude, this.longitude);
  }
  
}

class modalItem{
  
  modalItem(this.Image_UpLeft, this.Image_UpRight, this.Image_DownLeft, this.Image_DownRight, this.Hint_Up, this.Hint_Down);
  
  String Image_UpLeft, Image_UpRight, Image_DownLeft, Image_DownRight, Hint_Up, Hint_Down;
  
}
