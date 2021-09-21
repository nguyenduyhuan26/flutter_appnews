import 'package:flutter/material.dart';
import 'package:flutter_appnews/providers/news.dart';
import 'package:flutter_appnews/widgets/news_item.dart';
import 'package:provider/provider.dart';
import 'package:webfeed/webfeed.dart';

class TravelPage extends StatefulWidget {
  const TravelPage({Key key}) : super(key: key);

  @override
  _TravelPageState createState() => _TravelPageState();
}

GlobalKey<RefreshIndicatorState> refreshKey =
    GlobalKey<RefreshIndicatorState>();

class _TravelPageState extends State<TravelPage> {
  NewItem newItem = NewItem();
  String url = "https://vnexpress.net/rss/du-lich.rss";
  RssFeed feed;
  @override
  void initState() {
    super.initState();
    context.read<News>().load(url);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => News()),
      ],
      child: Scaffold(
        appBar: AppBar(title: Text("News")),
        body: SafeArea(
          child: Container(
            child: context.watch<News>().feed == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => context.read<News>().load(url),
                    key: refreshKey,
                    child: ListView.builder(
                      itemCount: context.watch<News>().feed.items.length,
                      itemBuilder: (BuildContext context, int index) {
                        var item = context.watch<News>().feed.items[index];

                        return Center(
                          child: Column(
                            children: [
                              Text("{context.watch<News>().items[index].link}"),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
