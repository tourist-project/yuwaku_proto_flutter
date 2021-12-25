import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix;
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:yuwaku_proto/tutorial_step_page.dart';

class TutorialPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TutorialPageState();
  }
}

class _TutorialPageState extends State<TutorialPage> {
  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(initialPage: 0);

    return Scaffold(
      backgroundColor: Color.fromRGBO(240, 233, 208, 100),
      appBar: AppBar(
        title: Text("使い方ガイド",
            style: TextStyle(color: prefix.Colors.black87)
        ),
      ),
      body: Center(
        child: Stack(
          children: [
            PageView(
              scrollDirection: Axis.horizontal,
              controller: controller,
              children: <Widget>[
                Center(
                  child: TutorialStepPage(PageData.first),
                ),
                Center(
                  child: TutorialStepPage(PageData.second),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    child: Center(
                      child: SmoothPageIndicator(
                        controller: controller,
                        count: 2,
                        effect: WormEffect(
                          dotColor: Colors.grey,
                          activeDotColor: Color.fromRGBO(186, 66, 43, 100)
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

enum PageData {
  first,
  second,
}

extension PageDataExtension on PageData {
  static final typeNames = {
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
