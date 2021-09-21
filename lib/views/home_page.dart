// import 'dart:io';

import 'dart:convert' show utf8;

import 'package:flutter/material.dart';
import 'package:flutter_appnews/model/items.dart';
import 'package:flutter_appnews/providers/getInfo.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RSSDemo extends StatefulWidget {
  //
  RSSDemo() : super();

  final String title = 'RSS Feed Demo';

  @override
  RSSDemoState createState() => RSSDemoState();
}

class RSSDemoState extends State<RSSDemo> {
  //
  static const String FEED_URL = "https://vnexpress.net/rss/tin-moi-nhat.rss";
  RssFeed _feed;
  String _title;
  static const String loadingFeedMsg = 'Loading Feed...';
  static const String feedLoadErrorMsg = 'Error Loading Feed.';
  static const String feedOpenErrorMsg = 'Error Opening Feed.';
  static const String placeholderImg = 'images/no_image.png';
  GlobalKey<RefreshIndicatorState> _refreshKey;

  updateTitle(title) {
    setState(() {
      _title = title;
    });
  }

  updateFeed(feed) {
    setState(() {
      _feed = feed;
    });
  }

  Future<void> openFeed(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: false,
      );
      return;
    }
    updateTitle(feedOpenErrorMsg);
  }

  load() async {
    updateTitle(loadingFeedMsg);
    loadFeed().then((result) {
      if (null == result || result.toString().isEmpty) {
        updateTitle(feedLoadErrorMsg);
        return;
      }
      updateFeed(result);
      updateTitle(_feed.title);
    });
  }

  Future<RssFeed> loadFeed() async {
    try {
      final client = http.Client();
      final response = await client.get(Uri.parse(FEED_URL));

      return RssFeed.parse(response.body);
    } catch (e) {
      return e;
    }
  }

  @override
  void initState() {
    super.initState();
    _refreshKey = GlobalKey<RefreshIndicatorState>();
    updateTitle(widget.title);
    load();
  }

  title(String title) {
    return Text(
      utf8.decode(title.runes.toList()),
      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  subtitle(subTitle) {
    return Text(
      utf8.decode(subTitle.runes.toList()),
      style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w100),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  // Widget thumbnail(imageUrl) {
  //   return Padding(
  //     padding: EdgeInsets.only(left: 15.0),
  //     child: CachedNetworkImage(
  //       placeholder: (context, url) => Image.asset(placeholderImg),
  //       imageUrl:
  //           "https://i1-vnexpress.vnecdn.net/2021/09/15/DUONGPHOSOCTRANGTRONGTHOIFIANG-6596-4211-1631698168.jpg?w=1200&h=0&q=100&dpr=1&fit=crop&s=surw8s_2aVzUsHjRQOZ-2w",
  //       height: 50,
  //       width: 70,
  //       alignment: Alignment.center,
  //       fit: BoxFit.fill,
  //     ),
  //   );
  // }

  rightIcon() {
    return Icon(
      Icons.keyboard_arrow_right,
      color: Colors.grey,
      size: 30.0,
    );
  }

  list() {
    return ListView.builder(
      itemCount: _feed.items.length,
      itemBuilder: (BuildContext context, int index) {
        final item = _feed.items[index];
        return ListTile(
          title: title(item.title),
          subtitle: subtitle(item.description),
          // leading: thumbnail("ad"),
          trailing: rightIcon(),
          contentPadding: EdgeInsets.all(5.0),
          onTap: () {
            GetInfo getInfo = GetInfo();
            print(_feed.items.length);
            print('------------');
            // var a = utf8.decode(item.description.runes.toList());
            var a = item.description
                .replaceAll(item.link, "")
                .replaceAll(
                    getInfo.getImage(
                        description: item.description, link: item.link),
                    "")
                .replaceAll('<a href=""><img src="" ></a></br>', '');

            // .replaceAll('<a href=" "><img src=" " ></a></br>', "");

            print(utf8.decode(a.runes.toList()));
            // print(getInfo.getImage(
            //     description: item.description, link: item.link));
          },
        );
      },
    );
  }

  isFeedEmpty() {
    return null == _feed || null == _feed.items;
  }

  body() {
    return isFeedEmpty()
        ? Center(
            child: CircularProgressIndicator(),
          )
        : RefreshIndicator(
            key: _refreshKey,
            child: list(),
            onRefresh: () => load(),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(onTap: () {}, child: Text(_title)),
      ),
      body: body(),
    );
  }
}
