import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'external_website.dart';

class DrawerLayout extends StatelessWidget {
  const DrawerLayout({
    Key? key,
    required this.webSites,
  }) : super(key: key);


  final ExternalWebSites webSites;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(0),
      children: [
        SizedBox(
          height: 150,
          child: DrawerHeader(
            decoration: BoxDecoration(),
            child: Container(
                child: Image(
                  image: AssetImage('assets/images/icon.png'),
                )
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.launch),
          title: const Text('Webサイト'),
          onTap: () {
            webSites.launchTourismURL();
          },
        ),
        ListTile(
          leading: Icon(Icons.camera_alt),
          title: const Text('フォトコンテスト'),
          onTap: () {
            webSites.launchPhotoContestURL();
          },
        ),
        ListTile(
          leading: Icon(Icons.list_alt),
          title: const Text('アンケート'),
          onTap: () {
            webSites.launchQuestionWebSURL();
          },
        ),
        ListTile(
          leading: Icon(Icons.insert_drive_file),
          title: const Text('利用規約'),
          onTap: () {

          },
        ),
        ListTile(
          leading: Icon(FontAwesomeIcons.twitter),
          title: const Text('運営Twitter'),
          onTap: () {
            webSites.twitterURL();
          },
        ),
      ],
    );
  }
}
