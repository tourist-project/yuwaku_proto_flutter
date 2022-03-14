import 'package:yuwaku_proto/main.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'homePage_Item.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreen();

}

class _HomeScreen extends State<HomeScreen>{


  @override
  Widget build(BuildContext context) {

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
            delegate:
            SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Card(
                      elevation: 15,
                      shadowColor: Colors.orange,
                      child: Column(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                  homeItems[index].title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: mediaHeightSize/30
                                ),
                              ),
                              Text(homeItems[index].eng_title)
                            ],
                          ),

                          Card(
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(homeItems[index].image),
                                  )
                              ),
                              width: mediaWidthSize/2,
                              height: mediaHeightSize/5.0,
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