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
    return Scaffold(
      backgroundColor: const Color.fromRGBO(240, 233, 208, 100),
      appBar: AppBar(title: const Text("使い方ガイド", style: TextStyle(color: prefix.Colors.black87))),
      body: PageView(
        scrollDirection: Axis.horizontal,
        controller: pageController,
        children: <Widget>[
          TutorialStepPage(PageData.first, pageController),
          TutorialStepPage(PageData.second, pageController)
        ],
      ),
    );
  }
}

enum PageData {
  first,
  second,
}

extension PageDataExtension on PageData {
  static const typeNames = {
    PageData.first: {
      'title': '観光スポットを探索',
      'description': '画像とヒントを頼りに観光スポットを探そう！！',
      'imagePath': 'assets/images/tutorial_image_step1.png'
    },
    PageData.second: {
      'title': 'スポットを見つけたら写真を撮影',
      'description': 'スポットに近づいたらカメラマークがでるよ！！',
      'imagePath': 'assets/images/tutorial_image_step2.png'
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
        Flexible(
            flex: 1,
            child: SmoothPageIndicator(
              controller: controller,
              count: 2,
              effect: const WormEffect(
                  dotColor: Colors.grey,
                  activeDotColor: Color.fromRGBO(186, 66, 43, 100)
              ),
            ),
        ),
      ],
    );
  }
}
