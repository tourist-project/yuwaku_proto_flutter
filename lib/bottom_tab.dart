import 'package:flutter/material.dart';
import 'package:yuwaku_proto/tutorial_page.dart';
import 'map_page.dart';
import 'package:yuwaku_proto/app_top_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentIndicatorProvider = StateProvider((ref) => 0);

class BottomTabPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentIndicatorProvider.state).state;

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: [
          TopPageView(selectItem: (index) => ref.watch(currentIndicatorProvider.notifier).state = index),
          MapPageState(),
          TutorialPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add_comment_sharp,),
            label: 'ホーム',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_location_alt_sharp,),
              label: '地図'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.help,
              ),
              label: '遊び方'),
        ],
        currentIndex: currentIndex,
        fixedColor: Colors.blueAccent,
        onTap: (index) => ref.watch(currentIndicatorProvider.notifier).state = index,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}