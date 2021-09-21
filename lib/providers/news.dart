import 'dart:convert' show utf8;
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class News with ChangeNotifier, DiagnosticableTreeMixin {
  RssFeed _feed;
  String title;
  List<RssItem> _items;
  // static const String loadingFeedMsg = 'Loading Feed...';
  // static const String feedLoadErrorMsg = 'Error Loading Feed.';
  // static const String feedOpenErrorMsg = 'Error Opening Feed.';
  static const String placeholderImg = 'images/no_image.png';
  RssFeed get feed => _feed;
  List<RssItem> get items => _items;
  Future<void> openFeed(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: false,
      );
      return;
    }
  }

  load(String url) async {
    print("load rss");

    updateTitle("Loading Feed...");
    await loadFeed(url).then((result) {
      if (null == result || result.toString().isEmpty) {
        updateTitle("Error Loading Feed.");
      }
      _feed = result;
      _items = result.items;
      print(items[3].link);
      print("load rss done ${feed.items[0].link ?? "abc"}");
      notifyListeners();

      return "done";
    });
  }

  Future<RssFeed> loadFeed(String url) async {
    print("loading......");

    try {
      final client = http.Client();
      final response = await client.get(Uri.parse(url));
      return RssFeed.parse(response.body);
    } catch (e) {
      //
    }
    return null;
  }

  updateTitle(title) {
    title = title;
  }

  isFeedEmpty() {
    return null == feed || null == feed.items;
  }

  String getImage({String description, String link}) {
    description.toString().replaceAll("$link", "").trim();

    if (description.indexOf('src="') == -1 &&
        description.indexOf('" ></a></br>') == -1) {
      return "";
    } else
      return description
          .substring(
              description.indexOf('src="'), description.indexOf('" ></a></br>'))
          .replaceAll('src="', "");
  }

  String getDescription({String description, String link}) {
    return utf8.decode(description
        .replaceAll(link, "")
        .replaceAll(getImage(description: description, link: link), "")
        .replaceAll('<a href=""><img src="" ></a></br>', '')
        .runes
        .toList());
  }
}
