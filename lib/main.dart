import 'package:flutter/material.dart';
import 'package:yuwaku_proto/bottom_tab.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  // 画面の向きを固定
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: AppBarTheme(color: Color.fromRGBO(240, 233, 208, 100),)
      ),
      home: BottomTabPage(),
    );
  }
}
