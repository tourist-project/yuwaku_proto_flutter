import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix;
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class TutorialPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(240, 233, 208, 100),
      appBar: AppBar(title: const Text("使い方ガイド", style: TextStyle(color: prefix.Colors.black87))),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flexible(
            flex: 8,
            child: PageView(
              scrollDirection: Axis.horizontal,
              controller: pageController,
              children: <Widget>[
                TutorialStepPage(PageData.first, pageController),
                TutorialStepPage(PageData.second, pageController),
                TutorialStepPage(PageData.third, pageController),
                TutorialStepPage(PageData.forth, pageController),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: SmoothPageIndicator(
              controller: pageController,
              count: 4,
              effect: const WormEffect(
                  dotColor: Colors.grey,
                  activeDotColor: Color.fromRGBO(186, 66, 43, 100)
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum PageData {
  first,
  second,
  third,
  forth,
}

extension PageDataExtension on PageData {
  static const typeNames = {
    PageData.first: {
      'title': '観光スポットの確認',
      'description': '湯涌のスポットを一覧で見てみよう！！',
      'imagePath': 'assets/images/tutorial_image_step1.png'
    },
    PageData.second: {
      'title': '距離を確認',
      'description': '写真を撮る目標地点までの距離を確認！！\n'
          'そして写真を撮ってみよう',
      'imagePath': 'assets/images/tutorial_image_step2.png'
    },
    PageData.third: {
      'title': '近くの写真',
      'description': 'スポット近くの写真で探索もラクラク',
      'imagePath': 'assets/images/tutorial_image_step3.png'
    },
    PageData.forth: {
      'title': '湯涌全体図',
      'description': '湯涌温泉街の全体図を確認！！',
      'imagePath': 'assets/images/tutorial_image_step4.png'
    }
  };

  Map<String, String> get typeName => typeNames[this]!;
}

class TutorialStepPage extends StatelessWidget {
  final PageData data;
  final PageController controller;
  TutorialStepPage(this.data, this.controller);

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            data.typeName['title']!,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: const Color.fromRGBO(186, 66, 43, 100),
            ),
          ),
        ),

        Flexible(
          flex: 7,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(data.typeName['imagePath']!, fit:BoxFit.contain),
          )
        ),
        Flexible(
          flex: 1,
          child: Text( data.typeName['description']!),
        ),
        const Padding(padding: EdgeInsets.all(20.0)),

      ],
    );
  }
}
