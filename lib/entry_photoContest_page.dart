import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'external_website.dart';

class PhotoContestEntry extends StatefulWidget {

  @override
  State<PhotoContestEntry> createState() => _PhotoContestEntryState();
}

class _PhotoContestEntryState extends State<PhotoContestEntry> {

  Map<String, String> _photoContestExplain = {
    '応募期間': '2022/10/22 〜 2022/10/26 12:00',
    '賞': '・湯涌ぼんぼり賞(1名)：金沢湯涌温泉氷室氷菓〜冬デザイン〜 1セット\n'
        '・ゆわく隠れた魅力賞(1名)金沢湯涌サイダー 柚子乙女セット 1セット',
    '応募資格': '湯涌ぼんぼり祭りに参加したこと',
    '応募作品': '湯涌ぼんぼり祭り当日に撮影した写真(撮影媒体は問わない)',
    '応募作品形式': '・ファイル形式：JPEGまたはPNG\n'
        '・アップロード可能なサイズ：10MBまで',
    '応募方法': '専用の応募フォームよりご応募ください',
    '注意事項': '公的良俗に反していない写真の投稿をお願いします',
    '審査方法': '・Tourism Projectと湯涌温泉観光協会の運営スタッフが以下の基準により審査致します\n'
        '・湯涌ぼんぼり祭り：ぼんぼり祭りの魅力が最も伝えられている写真\n'
        'ゆわく隠れた魅力賞：湯涌のちょっとした魅力を伝えるための写真',
    '審査結果': '・入賞した場合のみ、応募事項に入力いただいたメールアドレスにご連絡致します\n'
        '・2022/10/29に本サイトと湯涌町でポスターパネルにて発表させて頂きます\n'
        '応募作品は入賞発表後フォトラリーページにて公開させて頂きます',
    '応募作品の著作品・使用権': '・作品の使用の際には必ず応募時に応募者の入力されたお名前を掲載させて頂きます\n'
        '・ご応募いただいた作品は湯涌写真コンテスト及び湯涌町の宣伝に使用し、厳正に管理致します\n'
        '・著作権や肖像権について詳しくはこちらの利用規約に準じています。2次利用のある場合がございます',
  };

  int _counter = 0;
  ExternalWebSites webSites = ExternalWebSites();

  @override
  Widget build(BuildContext context) {
    final listJmp = _photoContestExplain.entries
        .map((e) => PhotoContestExplain(e.key, e.value)).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('写真コンテスト', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 5, left: 30, right: 30),
            child: Text(
              'アプリから撮った写真や、その他媒体で撮った写真で写真コンテストに応募できます',
              style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 15),
            ),
          ),
          Container(
            child: Text(
                  '応募や詳細はこちらのリンクから！',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w500  ,
                  fontSize: 15),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: InkWell(
              onTap: () {
                webSites.launchPhotoContestURL();
              },
              child: Container(
                width: double.infinity,
                child: Image(
                  image: AssetImage('assets/images/photo_contest_image.png'),
                ),
              ),
            ),
          ),
          Container(
            child: Text(
              '↓応募要項↓',
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),
            ),
          ),
          Flexible(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 5,
                  child: ListTile(
                    title: _textWidget(listJmp, index, _counter, 'title'),
                    subtitle: _textWidget(listJmp, index, _counter, 'explain'),
                  ),
                );
              },
              itemCount: _photoContestExplain.length,
            ),
          ),

        ],
      ),
    );
  }
}

class PhotoContestExplain {

  String title;
  String explain;
  PhotoContestExplain(this.title, this.explain);

}

Widget _textWidget(List list, int index, int counter, String key) {

  if (key == 'title') {
    return Text(
      list[index].title,
      style: TextStyle(
          fontSize: 16,
      ),
    );
  }
  if (key == 'explain') {
    return Text(
      list[index].explain,
    );
  } else {
    return Text('nothing');
  }

}


