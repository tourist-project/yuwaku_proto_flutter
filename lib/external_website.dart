import 'package:url_launcher/url_launcher.dart';

/// WebサイトへのURLたち
class ExternalWebSites{

  Future launchTourismUrl() async {
    var url = "https://totteku.tourism-project.com/contact";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Unable to launch url $url';
    }
  }

  Future photoContestUrl() async {
    var url = "https://totteku.tourism-project.com/album";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Unable to launch url $url';
    }
  }

  Future questionWebSUrl() async {
    var url = "https://totteku.tourism-project.com/";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Unable to launch url $url';
    }
  }

  Future twitterUrl() async {
    var url = "https://twitter.com/kit_tourism";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Unable to launch url $url';
    }
  }

}
