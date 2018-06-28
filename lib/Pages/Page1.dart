import 'package:flutter/material.dart';

class Page1 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final double myTextSize = 30.0;
    final TextStyle myTextStyle =
    new TextStyle(color: Colors.grey, fontSize: myTextSize);

    var column = new Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        new CeneteredCard(
          title: new Text(
            "Page1",
            style: myTextStyle,
          ),
        )
      ],
    );

    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text("Zbiórki"),
      ),
      body: new Container(
        padding: const EdgeInsets.only(bottom: 2.0),
        child: new Container(
          child: new SingleChildScrollView(child: column),
        ),
      ),
    );
  }
}

class CeneteredCard extends StatelessWidget {
  final Widget title;

  CeneteredCard({this.title});

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: const EdgeInsets.only(bottom: 1.0),
      child: new Card(
        child: new Container(
            padding: const EdgeInsets.all(20.0),
            child: new Center(child: this.title)
        ),
      ),
    );
  }
}