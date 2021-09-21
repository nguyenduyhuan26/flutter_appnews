import 'package:flutter/material.dart';
import 'package:flutter_appnews/providers/news.dart';
import 'package:flutter_appnews/views/home_page.dart';
import 'package:flutter_appnews/views/travel_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => News()),
        ],
        // child: RSSDemo(),
        child: TravelPage(),
      ),
    );
  }
}
