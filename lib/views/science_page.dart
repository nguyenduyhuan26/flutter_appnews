import 'package:flutter/material.dart';
import 'package:flutter_appnews/providers/news.dart';
import 'package:flutter_appnews/widgets/list_horizontal.dart';
import 'package:flutter_appnews/widgets/list_vertical.dart';
import 'package:provider/provider.dart';

// view ngang + doc
class SciencePage extends StatefulWidget {
  const SciencePage({Key key}) : super(key: key);

  @override
  _SciencePageState createState() => _SciencePageState();
}

GlobalKey<RefreshIndicatorState> refreshKey =
    GlobalKey<RefreshIndicatorState>();

class _SciencePageState extends State<SciencePage> {
  ListVertical listVertical;
  ListHorizontal listHorizontal;

  String url = "https://vnexpress.net/rss/khoa-hoc.rss";
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
        appBar: AppBar(
          title: Text("Khoa Học"),
          //leading: Icon(Icons.refresh),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: context.watch<News>().feed == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        list1(),
                        list2(),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget list1() {
    return RefreshIndicator(
      onRefresh: () => context.read<News>().load(url),
      key: refreshKey,
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.38,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: context.watch<News>().feed.items.length,
            itemBuilder: (BuildContext buildContext, int index) {
              var item = context.watch<News>().feed.items[index];

              listHorizontal = ListHorizontal(
                fix: 0.36,
                title: item.title,
                description: context.read<News>().getDescription(
                    description: item.description, link: item.link),
                imageUrl: context
                    .read<News>()
                    .getImage(description: item.description, link: item.link),
              );
              return index % 2 == 0
                  ? Center(
                      child: GestureDetector(
                          onTap: () {
                            context.read<News>().openFeed(item.link);
                          },
                          child: listHorizontal),
                    )
                  : Container();
            },
          ),
        ),
      ),
    );
  }

  Widget list2() {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.43,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: context.watch<News>().feed.items.length,
          itemBuilder: (BuildContext buildContext, int index) {
            var item = context.watch<News>().feed.items[index];
            listVertical = ListVertical(
                fix: 0.6,
                title: item.title,
                description: context.read<News>().getDescription(
                    description: item.description, link: item.link),
                imageUrl: context
                    .read<News>()
                    .getImage(description: item.description, link: item.link));

            return index % 2 != 0
                ? Center(
                    child: GestureDetector(
                        onTap: () {
                          context.read<News>().openFeed(item.link);
                        },
                        child: listVertical),
                  )
                : Container();
          },
        ),
      ),
    );
  }
}
