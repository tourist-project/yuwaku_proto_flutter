import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yuwaku_proto/take_spot_notifier.dart';
import 'package:yuwaku_proto/map_component/map_interactive_move.dart';
import 'package:yuwaku_proto/some_explain.dart';
import 'package:yuwaku_proto/bottom_tab.dart';
import 'package:yuwaku_proto/tutorial_page.dart';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  // 画面の向きを固定
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => TakeSpotNotifier())
        ],
        child: MyApp(camera: firstCamera)
      )
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  
  MyApp({Key? key, required this.camera});
  
  final CameraDescription  camera;
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blueGrey,
          textTheme: GoogleFonts.sawarabiGothicTextTheme(
            Theme.of(context).textTheme,
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: AppBarTheme(
            color: Color.fromRGBO(240, 233, 208, 100),
          )),

      home: BottomTabPage(camera: camera),

      routes: <String, WidgetBuilder>{
        '/some_explain': (BuildContext context) => Explain(),
        '/tutorial_page':(BuildContext context) => TutorialPage(),
        '/map_interactive_move':(BuildContext context) => InteractiveMap(title: '湯涌全体図'),
      },
    );
  }
}
