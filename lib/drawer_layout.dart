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
    final double mediaQueryHeight = MediaQuery.of(context).size.height;
    return Container(
      color: Color.fromRGBO(240, 233, 208, 10),
      child: ListView(
        padding: EdgeInsets.all(0),
        children: [
          Container(
            height: mediaQueryHeight/7,
            child: DrawerHeader(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color.fromRGBO(186, 66, 43, 10),
                    width: 2
                  ),
                ),
              ),
              child: Container(
                  child: Image(
                    image: AssetImage('assets/images/SideBarLog.png'),
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
            title: const Text('写真コンテスト'),
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
              webSites.launchTermsOfUseURL();
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.twitter),
            title: const Text('運営Twitter'),
            tileColor: Color.fromRGBO(240, 233, 208, 10),
            onTap: () {
              webSites.twitterURL();
            },
          ),
        ],
      ),
    );
  }
}
