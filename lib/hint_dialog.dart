import 'package:flutter/material.dart';
import 'goal.dart';
import 'homepage_component/homePage_Item.dart';

class HintDialog extends StatelessWidget {
  Goal goal;
  HintDialog(this.goal);
  late modalItem _modalItem;
  late String _title;

  void getModelItem(Goal goal) {
    switch (goal) {
      case Goal.himurogoya:
        _title = "氷室小屋";
        _modalItem = modalItem(
            'assets/images/HimuroGoya/HimuroGoya.png',
            'assets/images/HimuroGoya/Himuro2.png',
            'assets/images/HimuroGoya/HimuroGoya3.png',
            'assets/images/HimuroGoya/HimuroGoya4.png',
            '山の中にある小屋',
            '坂を登り、湖を囲む'
        );
        break;
      case Goal.yumejikan:
        _title = "金沢夢二館";
        _modalItem = modalItem(
            'assets/images/Yumezikan/Yumezikan1.JPG',
            'assets/images/Yumezikan/Yumezikan4.png',
            'assets/images/Yumezikan/Yumezikan2.JPG',
            'assets/images/Yumezikan/Yumezikan.png',
            '中央の広場の近く',
            '総湯の近くにある'
        );
        break;
      case Goal.soyu:
        _title = "総湯";
        _modalItem = modalItem(
            'assets/images/Soyu/Soyu3.jpg',
            'assets/images/Soyu/Modal_Soyu.png',
            'assets/images/Soyu/Soyu1.png',
            'assets/images/Soyu/Soyu2.png',
            '大きな階段の近く',
            '奥には山が潜む'
        );
        break;
      case Goal.ashiyu:
        _title = "足湯";
        _modalItem = modalItem(
            'assets/images/Ashiyu/Ashiyu2.png',
            'assets/images/Ashiyu/Ashiyu3.png',
            'assets/images/Ashiyu/Asiyu(temp).png',
            'assets/images/Ashiyu/Ashiyu1.jpg',
            '階段の上にある',
            '上には神社を見る'
        );
        break;
      case Goal.yakushiji:
        _title = "薬師寺";
        _modalItem = modalItem(
            'assets/images/Yakushizi1.png',
            'assets/images/Yakushizi2.png',
            'assets/images/Yakushizi3.JPG',
            'assets/images/YakushiziBack.jpg',
            '山の中にある神社',
            '稲荷神社から見えるかも？'
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    double modalWidth = MediaQuery.of(context).size.width;
    double modalHeight = MediaQuery.of(context).size.height;
    getModelItem(goal);
    return GestureDetector(
      onTap: () {Navigator.pop(context);},
      child: SimpleDialog(
        title: Text(_title),
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                          children: [
                            Expanded(
                              child: Container(
                                width: modalWidth / 4,
                                height: modalHeight /7,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.asset(
                                        _modalItem.Image_UpLeft,
                                        fit: BoxFit.cover
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            Expanded(
                              child: Container(
                                width: modalWidth / 4,
                                height: modalHeight /7,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.asset(
                                        _modalItem.Image_UpRight,
                                        fit: BoxFit.cover
                                    ),
                                  ),
                                ),
                              ),
                            ),

                          ]
                      ),
                      Row(
                          children: [
                            Expanded(
                              child: Container(
                                width: modalWidth / 4,
                                height: modalHeight /7,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.asset(
                                        _modalItem.Image_DownLeft,
                                        fit: BoxFit.cover
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                width: modalWidth / 4,
                                height: modalHeight /7,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.asset(
                                        _modalItem.Image_DownRight,
                                        fit: BoxFit.cover
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ]
                      ),
                    ]
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '・ ${_modalItem.Hint_Up}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(top: 5),
                        child: Text(
                          '・ ${_modalItem.Hint_Down}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ]
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}