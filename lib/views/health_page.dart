import 'package:flutter/material.dart';
import 'package:flutter_appnews/providers/news.dart';
import 'package:flutter_appnews/widgets/list_horizontal.dart';
import 'package:provider/provider.dart';

/// view ngang!!!
class HealthPage extends StatefulWidget {
  const HealthPage({Key key}) : super(key: key);

  @override
  _HealthPageState createState() => _HealthPageState();
}

class _HealthPageState extends State<HealthPage> {
  ListHorizontal newItem;
  String url = "https://vnexpress.net/rss/suc-khoe.rss";
  GlobalKey<RefreshIndicatorState> refreshKey =
      GlobalKey<RefreshIndicatorState>();
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
        appBar: AppBar(title: Text("Sức Khoẻ")),
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
                      scrollDirection: Axis.horizontal,
                      itemCount: context.watch<News>().feed.items.length,
                      itemBuilder: (BuildContext buildContext, int index) {
                        var item = context.watch<News>().feed.items[index];
                        newItem = ListHorizontal(
                          fix: 1,
                          title: item.title,
                          description: context.read<News>().getDescription(
                              description: item.description, link: item.link),
                          imageUrl: context.read<News>().getImage(
                              description: item.description, link: item.link),
                        );
                        return Container(
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
