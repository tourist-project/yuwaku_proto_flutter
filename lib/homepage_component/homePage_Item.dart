import 'package:yuwaku_proto/main.dart';
import 'package:flutter/material.dart';

class HomePageItem{

  HomePageItem(this.title, this.eng_title, this.explain, this.image){
    print('インスタンスの生成');
  }

  String title , eng_title, explain, image;

}

class modalItem{
  
  modalItem(this.Image_UpLeft, this.Image_UpRight, this.Image_DownLeft, this.Image_DownRight, this.Hint_Up, this.Hint_Down);
  
  String Image_UpLeft, Image_UpRight, Image_DownLeft, Image_DownRight, Hint_Up, Hint_Down;
  
}
