import 'package:url_launcher/url_launcher.dart';

/// WebサイトへのURLたち
class ExternalWebSites{

  Future launchTourismURL() async {
    var url = "https://totteku.tourism-project.com/contact";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Unable to launch url $url';
    }
  }

  Future launchPhotoContestURL() async {
    var url = "https://totteku.tourism-project.com/album";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Unable to launch url $url';
    }
  }

  Future launchQuestionWebSURL() async {
    var url = "https://totteku.tourism-project.com/";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Unable to launch url $url';
    }
  }

  Future twitterURL() async {
    var url = "https://twitter.com/kit_tourism";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Unable to launch url $url';
    }
  }

}
