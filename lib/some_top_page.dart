import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yuwaku_proto/goal_listview_cell.dart';
import 'package:yuwaku_proto/homepage_component/homePage_Item.dart';
import 'package:flutter/cupertino.dart';
import 'package:yuwaku_proto/shared_preferences_manager.dart';
import 'take_spot_notifier.dart';
import 'goal.dart';
import 'drawer_layout.dart';
import 'external_website.dart';

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
        'みどりの里',
        "Midorino Sato",
        '',
        '',
        36.490402927190495, 136.75423519148546
    ),
    HomePageItem('薬師寺', "Yakushizi",
      '蕎麦打ち体験や梨の収穫体験などの様々なイベントが1年を通して行われ,'
          '4月中旬〜12月中旬の毎週日曜日と水曜日に朝市が開催され新鮮な農作物などをお買い求めいただけます。',
      'assets/images/Yakushizi1.png',
      36.48566, 136.75794,
      )
  ];

  ExternalWebSites webSites = ExternalWebSites();

  @override
  void initState() {
    super.initState();
    _initCheckmarkState();
  }

  // アプリ起動時に保存したデータを読み込む
  void _initCheckmarkState() async {
    final prefs = SharedPreferencesManager();
    var isTookHimurogoya = await prefs.getIsTook(Goal.himurogoya);
    if (isTookHimurogoya == true) {
      context.read<TakeSpotNotifier>().notifyTakedHimurogoya();
    }
    var isTookYumejikan = await prefs.getIsTook(Goal.yumejikan);
    if (isTookYumejikan == true) {
      context.read<TakeSpotNotifier>().notifyTakedYumejikan();
    }
    var isTookSoyu = await prefs.getIsTook(Goal.soyu);
    if (isTookSoyu == true) {
      context.read<TakeSpotNotifier>().notifyTakedSoyu();
    }
    var isTookAshiyu = await prefs.getIsTook(Goal.ashiyu);
    if (isTookAshiyu == true) {
      context.read<TakeSpotNotifier>().notifyTakedAshiyu();
    }
    var isTookYakushiji = await prefs.getIsTook(Goal.yakushiji);
    if (isTookYakushiji == true) {
      context.read<TakeSpotNotifier>().notifyTakedYakushiji();
    }
    var isTookmidorinosato = await prefs.getIsTook(Goal.midorinosato);
    if (isTookmidorinosato == true) {
      context.read<TakeSpotNotifier>().notifyTakedMidorinosato();
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

    var _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => _scaffoldKey.currentState!.openDrawer(),
          icon: Icon(Icons.menu, color:Colors.white),
        ),
        centerTitle: true,
        title: Text('マイスタンプ',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: const Color.fromRGBO(240, 233, 208, 100),
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => TakeSpotNotifier())
        ],
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10),
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
                SizedBox(height: 10),
                ListView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    GoalListViewCell(
                      homeItems: homeItems[0],
                      heightSize: heightSize,
                      widthSize: widthSize,
                      errorGetDistance: homeItems[0].distance,
                      camera: camera,
                      isTookPicture: context
                          .watch<TakeSpotNotifier>()
                          .isTakedHimurogoya,
                      goal: Goal.himurogoya,
                    ),
                    GoalListViewCell(
                        homeItems: homeItems[1],
                        heightSize: heightSize,
                        widthSize: widthSize,
                        errorGetDistance: homeItems[1].distance,
                        camera: camera,
                        isTookPicture: context
                            .watch<TakeSpotNotifier>()
                            .isTakedYumejikan,
                        goal: Goal.yumejikan
                    ),
                    GoalListViewCell(
                        homeItems: homeItems[2],
                        heightSize: heightSize,
                        widthSize: widthSize,
                        errorGetDistance: homeItems[2].distance,
                        camera: camera,
                        isTookPicture: context
                            .watch<TakeSpotNotifier>()
                            .isTakedSoyu,
                        goal: Goal.soyu
                    ),
                    GoalListViewCell(
                        homeItems: homeItems[3],
                        heightSize: heightSize,
                        widthSize: widthSize,
                        errorGetDistance: homeItems[3].distance,
                        camera: camera,
                        isTookPicture: context
                            .watch<TakeSpotNotifier>()
                            .isTakedMidorinosato,
                        goal: Goal.midorinosato
                    ),
                    GoalListViewCell(
                      homeItems: homeItems[4],
                      heightSize: heightSize,
                      widthSize: widthSize,
                      errorGetDistance: homeItems[4].distance,
                      camera: camera,
                      isTookPicture: context
                          .watch<TakeSpotNotifier>()
                          .isTakedYakushiji,
                      goal: Goal.yakushiji,
                    ),
                    SizedBox(height: 50),
                  ],
                ),
              ],
            ),
          ),
        ),
      drawer: Drawer(
        child: DrawerLayout(webSites: webSites),
    ),
      );
  }
}

