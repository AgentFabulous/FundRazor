import 'package:flutter/material.dart';
import 'package:FundRazor/pages/Page0.dart';
import 'package:FundRazor/pages/Page1.dart';
import 'package:FundRazor/pages/Page2.dart';
import 'package:FundRazor/internal/data.dart';

void main() => runApp(new FundRazorApp());

PageController pageControl;

class FundRazorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'FundRazor',
      home: new MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
  int page = 0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new PageView(children: [
          new Page0(),
          new Page1(),
          new Page2(),
        ], controller: pageControl, onPageChanged: onPageChange),
        bottomNavigationBar: new BottomNavigationBar(
          items: [
            new BottomNavigationBarItem(
              icon: new Icon(Icons.history),
              title: new Text("Ongoing"),
            ),
            new BottomNavigationBarItem(
              icon: new Icon(Icons.done),
              title: new Text("Completed"),
            ),
            new BottomNavigationBarItem(
              icon: new Icon(Icons.settings),
              title: new Text("Settings"),
            ),
          ],
          onTap: navTapped,
          currentIndex: page,
        ));
  }

  @override
  void initState() {
    super.initState();
    pageControl = new PageController();
    restoreData().then((result) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageControl.dispose();
    writeData();
  }

  void onPageChange(int page) {
    setState(() {
      this.page = page;
    });
  }

  void navTapped(int page) {
    pageControl.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }
}
