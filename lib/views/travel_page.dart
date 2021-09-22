import 'package:flutter/material.dart';
import 'package:flutter_appnews/providers/news.dart';
import 'package:flutter_appnews/widgets/list_vertical.dart';
import 'package:provider/provider.dart';

// view dọc
class TravelPage extends StatefulWidget {
  const TravelPage({Key key}) : super(key: key);

  @override
  _TravelPageState createState() => _TravelPageState();
}

GlobalKey<RefreshIndicatorState> refreshKey =
    GlobalKey<RefreshIndicatorState>();

class _TravelPageState extends State<TravelPage> {
  ListVertical newItem;
  String url = "https://vnexpress.net/rss/du-lich.rss";
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
        appBar: AppBar(title: Text("Du Lịch")),
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: context.watch<News>().feed == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => context.read<News>().load(url),
                    key: refreshKey,
                    child: ListView.builder(
                      itemCount: context.watch<News>().feed.items.length,
                      itemBuilder: (BuildContext buildContext, int index) {
                        var item = context.watch<News>().feed.items[index];
                        newItem = ListVertical(
                          title: item.title,
                          description: context.read<News>().getDescription(
                              description: item.description, link: item.link),
                          imageUrl: context.read<News>().getImage(
                              description: item.description, link: item.link),
                        );
                        return Center(
                          child: GestureDetector(
                            onTap: () {
                              context.read<News>().openFeed(item.link);
                            },
                            child: newItem,
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
