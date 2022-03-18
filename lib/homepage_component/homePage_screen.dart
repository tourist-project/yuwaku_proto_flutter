import 'package:flutter/cupertino.dart';
import 'package:yuwaku_proto/SizeConfig.dart';
import 'package:yuwaku_proto/main.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'homePage_Item.dart';
import 'package:auto_size_text/auto_size_text.dart';


class HomeScreen extends StatefulWidget {

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreen();

}

class _HomeScreen extends State<HomeScreen>{


  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);
    double mediaWidthSize = MediaQuery.of(context).size.width;
    double mediaHeightSize = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar(
            pinned: true,
            expandedHeight: 100,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'トップページ',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              background: FlutterLogo() /// なんかいい感じの写真とか挿入したい
            ),
          ),

          SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: mediaHeightSize/2,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 0.0,
              childAspectRatio: 1.0,
            ),
            delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
              SizeConfig().init(context);
              return Card(
                elevation: 20,
                shadowColor: Colors.orange,
                child: Column(
                  children: <Widget>[
                    Flexible(
                      flex: 2,
                      child: Column(
                        children: <Widget>[
                          Flexible(
                            flex: 2,
                            child: AutoSizeText(
                              homeItems[index].title,
                              style: TextStyle(
                              fontWeight: FontWeight.bold,
                                fontSize: mediaHeightSize/30,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: AutoSizeText(
                              homeItems[index].eng_title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: mediaHeightSize/50,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Card(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(homeItems[index].image),
                              )
                          ),
                        ),
                      ),
                    ),
                    // Text(homeItems[index].explain)
                  ],
                ),
              );
              },
              childCount: homeItems.length,
            ),
          ),

          /*
          SliverFixedExtentList(
            itemExtent: 50.0,
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.lightBlue[100 * (index % 9)],
                  child: Text('List Item $index'),
                );
              },
            ),
          ),
        */
          ],
      )
    );
  }
}