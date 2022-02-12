import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui' as ui;
import 'package:carousel_slider/carousel_slider.dart';

import 'map_page.dart';

class clearpage extends StatefulWidget {
  double width = 0, height = 0;
  var imagephotos = <Expanded>[];
  List<MapItem> mapItems = [];
  bool is_init = false;

  clearpage(double width, double height, List<MapItem> mapItems) {
    this.width = width;
    this.height = height;
    this.mapItems = mapItems;
  }
  _clearpage createState() => _clearpage(this.width, this.height, this.mapItems);
}

class _clearpage extends State<clearpage> {
  double width = 0, height = 0;
  var imagephotos = <Expanded>[];
  List<MapItem> mapItems = [];
  bool is_init = false;

  _clearpage(double width, double height, List<MapItem> mapItems) {
    this.width = width;
    this.height = height;
    this.mapItems = mapItems;
  }

  Future<void> _launchURL() async {
    const url = "https://totteku.tourism-project.com/";
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!is_init) {
      this.mapItems.map((e) async {
        if (e.photoImage == null) {
          await e.loadInitialImage();
        }
        final img = await e.getDisplayImageToImageWidget();
        return img;
      }).forEach((e) {
        this.imagephotos.add(Expanded(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  child: FutureBuilder(
                    future: e,
                    builder:(BuildContext context,
                      AsyncSnapshot<Image?> snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data != null) {
                            return snapshot.data!;
                          }
                        }
                      return Container(
                        child: Text('画像ロード中...'),
                      );
                    }
                  ),
                )
        ));
      });
      this.is_init = true;
    }

    return Container(
      color: Color.fromRGBO(240, 233, 208, 1),
      child: Column(
        children: [
          (this.imagephotos.length >= 2
              ? Expanded(
                  flex: 2,
                  child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      child: Row(
                        children: <Widget>[
                          this.imagephotos[0],
                          this.imagephotos[1],
                        ],
                      ),
                      onTapDown: (details) {
                        if (details.globalPosition.dx < width / 2) {
                          showImage(context, imagephotos[0], 0);
                        } else if (details.globalPosition.dx > width / 2) {
                          showImage(context, imagephotos[1], 1);
                        }
                      }
                  ),
                )
            : Container()),
          this.imagephotos.length >= 4
              ? Expanded(
                  flex: 2,
                  child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      child: Row(
                        children: <Widget>[
                          this.imagephotos[2],
                          this.imagephotos[3],
                        ],
                      ),
                      onTapDown: (details) {
                        if (details.globalPosition.dx < width / 2) {
                          showImage(context, imagephotos[2], 2);
                        } else if (details.globalPosition.dx > width / 2) {
                          showImage(context, imagephotos[3], 3);
                        }
                      }
                  ),
              )
              : Container(),
          Expanded(
            flex: 5,
            child: Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                border:
                    Border.all(color: Color.fromRGBO(186, 66, 43, 1), width: 2),
              ),
              padding: const EdgeInsets.all(8),
              child: Scrollbar(
                child: SingleChildScrollView(
                  child: Container(
                    child: Text(
                      ' ゲームクリア！本日はユーザーテストにご協力いただきありがとうございます。\n'
                      ' 端末の返却のほどよろしくお願いいたします。\n'
                      ' 返却後にお礼の品などをお渡ししたいと考えております。',
                      style: TextStyle(fontSize: height / 40),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.all(5),
              width: 400,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color.fromRGBO(186, 66, 43, 1), width: 2),
              ),
              child: TextButton(
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    'フォトコンページに行く',
                    style: TextStyle(fontSize: height / 30, color: Colors.black),
                  ),
                ),
                onPressed: () {
                  _launchURL();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  @override
  Future<void> showImage(BuildContext context, Expanded otherimage, int checknumber) async{
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            height: this.height/2,
            width: this.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: CarouselSlider.builder(
                    options: CarouselOptions(
                      height: height,
                      initialPage: checknumber,
                      viewportFraction: 1,
                      enlargeCenterPage: true,
                    ),
                    itemCount: imagephotos.length,
                    itemBuilder: (context, index, realIndex) {
                      final path = imagephotos[index];
                      return Container(
                        child: Row(children: <Widget>[path]),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back),
              color: Colors.blue,
              iconSize: 40,
            )
          ],
        );
      },
    );
  }   
}