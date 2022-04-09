import 'package:yuwaku_proto/main.dart';
import 'package:flutter/material.dart';

class HomePageItem{

  HomePageItem(this.title, this.eng_title, this.explain, this.image){
    print('インスタンスの生成');
  }

  String title , eng_title, explain, image;

}

List<HomePageItem> homeItems = [
  HomePageItem('氷室小屋', "Himurogoya",
      '氷室小屋は冷蔵施設がなく氷が大変貴重であった江戸時代に、大寒の雪を詰め'
          '天然の雪氷を夏まで長期保存するために作られた小屋です。湯涌ではこの雪詰めを体験'
          'できるイベントが開催されます。',
      'assets/images/HimuroGoya.png'),

  HomePageItem('金沢夢二館', "KanazawaYumejikan",
      '大正時代を代表する詩人画家の竹下夢二の記念館です。旅、女性、信仰心の3つ'
          'のテーマから、遺品や作品を通して夢二の芸術性や人間性を紹介しています。',
      'assets/images/Yumezikan.png'),

  HomePageItem('総湯', "Soyu",
      '湯涌温泉の日帰り温泉。浴室はガラス窓であり、内湯でも開放的な気分になります。'
          '観光客だけでなく地元の方々にも日々利用されている名湯になります。',
      'assets/images/KeigoSirayu.png'),

  HomePageItem('足湯', "Ashiyu",
      '湯涌に2つある足湯の1つです。足だけの入浴なので無理なく体をしんから温める'
          'ことができます。無料なのでぜひ足湯を体験してみていかかでしょう。',
      'assets/images/Asiyu(temp).png'),

  HomePageItem('みどりの里', "Midorinosato",
      '蕎麦打ち体験や梨の収穫体験などの様々なイベントが1年を通して行われます。'
          '4月中旬〜12月中旬の毎週日曜日と水曜日に朝市が開催され新鮮な農作物などをお買い求めいただけます。',
      'assets/images/MidorinoSato.png'),
];

class ModalItem{
  
  ModalItem(this.Image_UpLeft, this.Image_UpRight, this.Image_DownLeft, this.Image_DownRight, this.Hint_Up, this.Hint_Down);
  
  String Image_UpLeft, Image_UpRight, Image_DownLeft, Image_DownRight, Hint_Up, Hint_Down;
}

List<ModalItem>ModalContents = [
  ModalItem(
      'assets/images/HimuroGoya.png',
      'assets/images/HimuroGoya.png',
      'assets/images/HimuroGoya.png',
      'assets/images/HimuroGoya.png',
      '山の中にある小屋',
      '坂を登り、湖を囲む'
  ),
       
  ModalItem(
    'assets/images/Yumezikan.png',
    'assets/images/Yumezikan.png',
    'assets/images/Yumezikan.png',
    'assets/images/Yumezikan.png',
    '中央の広場の近く',
    '総湯の近くにある'
  ),
       
  ModalItem(
    'assets/images/KeigoSirayu.png',
    'assets/images/KeigoSirayu.png', 
    'assets/images/KeigoSirayu.png',
    'assets/images/KeigoSirayu.png',
    '大きな階段の近く',
    '奥には山が潜む'
  ),
         
  ModalItem(
    'assets/images/Asiyu(temp).png',
    'assets/images/Asiyu(temp).png',
    'assets/images/Asiyu(temp).png', 
    'assets/images/Asiyu(temp).png',
    '階段の上にある',
    '上には神社を見る'
  ),
        
  ModalItem(
    'assets/images/MidorinoSato.png',
    'assets/images/MidorinoSato.png', 
    'assets/images/MidorinoSato.png',
    'assets/images/MidorinoSato.png',
    '近くには赤い郵便ポストがある',
    '近くには大きな木がある'
  )
];
