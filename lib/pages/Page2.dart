import 'package:flutter/material.dart';

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double myTextSize = 30.0;
    final TextStyle myTextStyle =
        new TextStyle(color: Colors.grey, fontSize: myTextSize);

    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text("Settings"),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'Work in Progress!',
              style: myTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
