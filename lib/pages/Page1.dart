import 'package:flutter/material.dart';
import 'package:skarbnicaskarbnika/internal/ui_common.dart';

bool isDone = true;

class Page1 extends StatefulWidget {
  @override
  _Page1 createState() => new _Page1();
}

class _Page1 extends State<Page1> {
  List<Widget> cards;

  @override
  Widget build(BuildContext context) {
    cards = buildTiles(isDone);
    var column = new Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: cards,
    );

    return new Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          title: new Text("Completed"),
        ),
        body: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new Container(
                child: new Text("Current amount",
                    style: new TextStyle(fontSize: 20.0, color: Colors.grey),
                    textAlign: TextAlign.center),
                padding: EdgeInsets.only(top: 80.0),
              ),
              new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Container(
                      child: new Text("\$",
                          style: new TextStyle(fontSize: 20.0),
                          textAlign: TextAlign.center),
                      padding: EdgeInsets.only(top: 0.0, bottom: 100.0),
                    ),
                    new Padding(padding: EdgeInsets.all(2.0)),
                    new Container(
                      child: new Text("99999",
                          style: new TextStyle(fontSize: 50.0),
                          textAlign: TextAlign.center),
                      padding: EdgeInsets.only(top: 20.0, bottom: 100.0),
                    ),
                  ]),
              new Container(
                padding: const EdgeInsets.only(bottom: 2.0),
                child: new Container(
                  child: new SingleChildScrollView(child: column),
                ),
              ),
            ]));
  }
}
