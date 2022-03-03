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

    final mediaSize = MediaQuery.of(context).size;

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
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 300.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 0.6,
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
                                  homeItems[index].title
                              ),
                              Text(homeItems[index].eng_title)
                            ],
                          ),

                          Card(
                            child: Image(
                              image: AssetImage(homeItems[index].image,
                              ),
                          ),
                          ),
                          Text(homeItems[index].explain),


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