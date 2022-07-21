import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yuwaku_proto/download_image_notifier.dart';
import 'package:yuwaku_proto/goal_listview_cell.dart';
import 'package:yuwaku_proto/homepage_component/homePage_Item.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:yuwaku_proto/shared_preferences_manager.dart';
import 'checkmark_notifier.dart';
import 'goal.dart';

class RunTopPage extends StatefulWidget {
  const RunTopPage({Key? key, required this.camera}) : super(key: key);

  final CameraDescription camera;
  @override
  State<RunTopPage> createState() => _RunTopPage(camera: camera);
}

class _RunTopPage extends State<RunTopPage> {
  _RunTopPage({Key? key, required this.camera});
  final CameraDescription camera;

  /*学校でテスト
  LC：36.5309848,136.6271052
  1号館：36.5309848,136.6271052
   */
  List<HomePageItem> homeItems = [
    HomePageItem(
      '氷室小屋',
      "Himurogoya",
      '氷室小屋は冷蔵施設がなく氷が大変貴重であった江戸時代に、大寒の雪を詰め'
          '天然の雪氷を夏まで長期保存するために作られた小屋です。湯涌ではこの雪詰めを体験'
          'できるイベントが開催されます。',
      'assets/images/HimuroGoya/HimuroGoya.png',
      36.48346516395541,
      136.75701193508996,
    ),
    HomePageItem(
        '金沢夢二館',
        "KanazawaYumejikan",
        '大正時代を代表する詩人画家の竹下夢二の記念館です。旅、女性、信仰心の3つ'
            'のテーマから、遺品や作品を通して夢二の芸術性や人間性を紹介しています。',
        'assets/images/Yumezikan/Yumezikan.png',
        36.48584951599308, 136.75738876226737
    ),
    HomePageItem(
      '総湯',
      "Soyu",
      '湯涌温泉の日帰り温泉。浴室はガラス窓であり、内湯でも開放的な気分になります。'
          '観光客だけでなく地元の方々にも日々利用されている名湯になります。',
      'assets/images/Soyu/KeigoSirayu.png',
      36.485425901995455, 136.75758738535384,
    ),
    HomePageItem(
        '足湯',
        "Ashiyu",
        '湯涌に2つある足湯の1つです。足だけの入浴なので無理なく体をしんから温める'
            'ことができます。無料なのでぜひ足湯を体験してみていかかでしょう。',
        'assets/images/Ashiyu/Asiyu(temp).png',
        36.48582537854954, 136.7574341842218
    ),
    HomePageItem('薬師寺', "Yakushizi",
      '蕎麦打ち体験や梨の収穫体験などの様々なイベントが1年を通して行われ,'
          '4月中旬〜12月中旬の毎週日曜日と水曜日に朝市が開催され新鮮な農作物などをお買い求めいただけます。',
      'assets/images/Yakushizi1.png',
      36.48566, 136.75794,
      )
  ];

  @override
  void initState() {
    super.initState();
    _initCheckmarkState();
    _initImage();
  }

  // アプリ起動時に保存したデータを読み込む
  void _initCheckmarkState() async {
    final prefs = SharedPreferencesManager();
    var isTookHimurogoya = await prefs.getIsTook(Goal.himurogoya);
    if (isTookHimurogoya == true) {
      context.read<CheckmarkNotifier>().notifyTakedHimurogoya();
    }
    var isTookYumejikan = await prefs.getIsTook(Goal.yumejikan);
    if (isTookYumejikan == true) {
      context.read<CheckmarkNotifier>().notifyTakedYumejikan();
    }
    var isTookSoyu = await prefs.getIsTook(Goal.soyu);
    if (isTookSoyu == true) {
      context.read<CheckmarkNotifier>().notifyTakedSoyu();
    }
    var isTookAshiyu = await prefs.getIsTook(Goal.ashiyu);
    if (isTookAshiyu == true) {
      context.read<CheckmarkNotifier>().notifyTakedAshiyu();
    }
    var isTookYakushiji = await prefs.getIsTook(Goal.yakushiji);
    if (isTookYakushiji == true) {
      context.read<CheckmarkNotifier>().notifyTakedYakushiji();
    }
  }

  void _initImage() async {
    final prefs = SharedPreferencesManager();
    var himurogoyaImageUrl = await prefs.getDownloaUrl(Goal.himurogoya);
    if (himurogoyaImageUrl != null) {
      context.read<DownloadImageNotifier>().notifyDownloadHimurogoyaImage(himurogoyaImageUrl);
    }
    var yumejikanImageUrl = await prefs.getDownloaUrl(Goal.yumejikan);
    if (yumejikanImageUrl != null) {
      context.read<DownloadImageNotifier>().notifyDownloadYumejikanImage(yumejikanImageUrl);
    }
    var soyuImageUrl = await prefs.getDownloaUrl(Goal.soyu);
    if (soyuImageUrl != null) {
      context.read<DownloadImageNotifier>().notifyDownloadSoyuImage(soyuImageUrl);
    }
    var ashiyuImageUrl = await prefs.getDownloaUrl(Goal.ashiyu);
    if (ashiyuImageUrl != null) {
      context.read<DownloadImageNotifier>().notifyDownloadAshiyuImage(ashiyuImageUrl);
    }
    var yakushijiImageUrl = await prefs.getDownloaUrl(Goal.yakushiji);
    if (yakushijiImageUrl != null) {
      context.read<DownloadImageNotifier>().notifyDownloadYakushijiImage(yakushijiImageUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    double heightSize = MediaQuery
        .of(context)
        .size
        .height;
    double widthSize = MediaQuery
        .of(context)
        .size
        .width;

    return SafeArea(
        child: Scaffold(
          body: MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => CheckmarkNotifier()),
              ChangeNotifierProvider(create: (_) => DownloadImageNotifier())
            ],
              // TODO: SingleChildScrollViewの高さを要素に応じて可変にするべき
              child: SingleChildScrollView(
                child: Container(
                  width: widthSize,
                  height: heightSize * 2.8,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          margin: EdgeInsets.only(
                              top: widthSize / 12, left: widthSize / 12),
                          width: widthSize,
                          height: heightSize / 16,
                          child: AutoSizeText(
                              '目標一覧', style: TextStyle(fontSize: widthSize / 12)),
                        ),
                      ),
                      AutoSizeText(
                        '電球をタップするとヒントを見ることが出来ます。',
                        style: TextStyle(fontSize: 20),
                      ),
                      AutoSizeText(
                        '入場制限で入れないスポットはスキップしてください。',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.red
                        ),
                      ),
                    Expanded(
                      flex: 35,
                      child: Container(
                        margin: EdgeInsets.only(top: widthSize / 18),
                        child: ListView(
                          scrollDirection: Axis.vertical,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            GoalListViewCell(
                                homeItems: homeItems[0],
                                heightSize: heightSize,
                                widthSize: widthSize,
                                errorGetDistance: homeItems[0].distance,
                                camera: camera,
                                isTookPicture: context
                                    .watch<CheckmarkNotifier>()
                                    .isTakedHimurogoya,
                                downloadImageUrl: context
                                    .watch<DownloadImageNotifier>()
                                    .himurogoyaImageUrl,
                                goal: Goal.himurogoya,
                              ),
                              GoalListViewCell(
                                  homeItems: homeItems[1],
                                  heightSize: heightSize,
                                  widthSize: widthSize,
                                  errorGetDistance: homeItems[1].distance,
                                  camera: camera,
                                  isTookPicture: context
                                      .watch<CheckmarkNotifier>()
                                      .isTakedYumejikan,
                                  downloadImageUrl: context
                                      .watch<DownloadImageNotifier>()
                                      .yumejikanImageUrl,
                                  goal: Goal.yumejikan
                              ),
                              GoalListViewCell(
                                  homeItems: homeItems[2],
                                  heightSize: heightSize,
                                  widthSize: widthSize,
                                  errorGetDistance: homeItems[2].distance,
                                  camera: camera,
                                  isTookPicture: context
                                      .watch<CheckmarkNotifier>()
                                      .isTakedSoyu,
                                  downloadImageUrl: context
                                      .watch<DownloadImageNotifier>()
                                      .soyuImageUrl,
                                  goal: Goal.soyu
                              ),
                              GoalListViewCell(
                                  homeItems: homeItems[3],
                                  heightSize: heightSize,
                                  widthSize: widthSize,
                                  errorGetDistance: homeItems[3].distance,
                                  camera: camera,
                                  isTookPicture: context
                                      .watch<CheckmarkNotifier>()
                                      .isTakedAshiyu,
                                  downloadImageUrl: context
                                      .watch<DownloadImageNotifier>()
                                      .ashiyuImageUrl,
                                  goal: Goal.ashiyu
                              ),
                              GoalListViewCell(
                                homeItems: homeItems[4],
                                heightSize: heightSize,
                                widthSize: widthSize,
                                errorGetDistance: homeItems[4].distance,
                                camera: camera,
                                isTookPicture: context
                                    .watch<CheckmarkNotifier>()
                                    .isTakedYakushiji,
                                downloadImageUrl: context
                                    .watch<DownloadImageNotifier>()
                                    .yakushijiImageUrl,
                                goal: Goal.yakushiji,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    ),
    );
  }
}

