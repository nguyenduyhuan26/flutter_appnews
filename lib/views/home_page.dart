import 'package:flutter/material.dart';
import 'package:flutter_appnews/views/health_page.dart';
import 'package:flutter_appnews/views/science_page.dart';
import 'package:flutter_appnews/views/travel_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    int selectedIndex = 0;
    final pageController = PageController(initialPage: 0);
    return Scaffold(
      body: PageView(
        onPageChanged: (index) {
          selectedIndex = index;
        },
        controller: pageController,
        children: [
          TravelPage(),
          SciencePage(),
          HealthPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.black54,
        backgroundColor: Colors.white,
        currentIndex: selectedIndex,
        onTap: (index) {
          print("page");
          setState(() {
            selectedIndex = index;
            pageController.animateTo(index.toDouble(),
                duration: Duration(milliseconds: 500), curve: Curves.ease);
            pageController.jumpToPage(index);
          });
        },
        selectedItemColor: Colors.black54,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.card_travel),
            label: "Du Lịch",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.science),
            label: "Khoa Học",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.health_and_safety),
            label: "Sức Khoẻ",
          ),
        ],
      ),
    );
  }
}
