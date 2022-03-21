import 'package:flutter/material.dart';
import 'package:yuwaku_proto/google_map_page.dart';
import 'package:yuwaku_proto/map_page.dart';
import 'package:yuwaku_proto/camera_page.dart';
import 'package:yuwaku_proto/map_painter.dart';
import 'package:yuwaku_proto/plane_explain.dart';
import 'package:yuwaku_proto/some_explain.dart';
import 'package:yuwaku_proto/bottom_tab.dart';
import 'development_page.dart';
import 'package:yuwaku_proto/gameclear.dart';
import 'package:yuwaku_proto/app_top_view.dart';
import 'package:yuwaku_proto/tutorial_page.dart';
import 'package:flutter/services.dart';
import 'homepage_component/homePage_Item.dart';
import 'homepage_component/homePage_screen.dart';
import 'google_map_page.dart';


void main() {

  WidgetsFlutterBinding.ensureInitialized();
  // 画面の向きを固定
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: AppBarTheme(
            color: Color.fromRGBO(240, 233, 208, 100),
          )),
      home: HomeScreen(),
      routes: <String, WidgetBuilder>{
        '/map_page': (BuildContext context) => MapPage(title: '地図'),
        '/camera_page': (BuildContext context) => CameraPage(
            title: 'Camera page',
            mapItem: ModalRoute.of(context)!.settings.arguments as MapItem),
        '/some_explain': (BuildContext context) => Explain(),
        '/plane_explain': (BuildContext context) => PicExplain(title: '場所説明'),
        '/development_page': (BuildContext context) =>
            DevelopmentPage(title: '開発中'),
        // '/app_top_view':(BuildContext context) => TopPageView(),
        '/tutorial_page':(BuildContext context) => TutorialPage(),
        '/google_map_page':(BuildContext context) => GoogleMapPage(title: '地図画面'),
      },
    );
  }
}
