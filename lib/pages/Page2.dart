import 'package:flutter/material.dart';
import 'package:skarbnicaskarbnika/internal/ui_common.dart';

class Page2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final double myTextSize = 30.0;
    final TextStyle myTextStyle =
    new TextStyle(color: Colors.grey, fontSize: myTextSize);

    var column = new Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        new CenterCard(
          title: new Text(
            "Page2",
            style: myTextStyle,
          ),
        )
      ],
    );

    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text("Settings"),
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
