import 'package:flutter/material.dart';
import 'package:skarbnicaskarbnika/internal/data.dart';
import 'package:skarbnicaskarbnika/internal/common.dart';

class ListsCard extends StatelessWidget {
  final int index;

  ListsCard(this.index);

  @override
  Widget build(BuildContext context) {
    final double textSize = 20.0;
    final TextStyle textStyle = new TextStyle(fontSize: textSize);
    return new Container(
        padding: const EdgeInsets.only(top: 1.0),
        child: new Card(
          child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Container(
                  padding:
                      const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                  child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text(lists.allLists[index].name, style: textStyle),
                        new Text(
                            "Amount: " +
                                lists.allLists[index].recalculatedAmount
                                    .toString(),
                            style: new TextStyle(color: Colors.grey)),
                        new Text(
                          "Deadline: " + simpleDate(lists.allLists[index].date),
                          style: new TextStyle(color: Colors.grey),
                        ),
                      ]),
                ),
                new ButtonBar(
                  children: <Widget>[
                    new FlatButton(
                        onPressed: () => debugPrint("Delete"),
                        child: new Text("Delete",
                            style: new TextStyle(color: Colors.blue))),
                    new FlatButton(
                        onPressed: () => debugPrint("Edit"),
                        child: new Text("Edit",
                            style: new TextStyle(color: Colors.blue))),
                  ],
                ),
              ]),
        ));
  }
}

class CenterCard extends StatelessWidget {
  final Widget title;

  CenterCard({this.title});

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: const EdgeInsets.only(bottom: 1.0),
      child: new Card(
        child: new Container(
            padding: const EdgeInsets.all(20.0),
            child: new Center(child: this.title)),
      ),
    );
  }
}

List<Widget> buildTiles(bool isDone) {
  int _len = calculateLength(isDone);
  int x = 0;
  List<Widget> tiles = new List<Widget>(_len);
  for (int i = 0; i < lists.allLists.length; i++) {
    if (isDone) {
      if (lists.allLists[i].isDone) tiles[x++] = new ListsCard(i);
    } else {
      if (!lists.allLists[i].isDone) tiles[x++] = new ListsCard(i);
    }
  }
  return tiles;
}

Widget mCrossFade(Widget first, Widget second, bool fade) {
  return new AnimatedCrossFade(
    duration: const Duration(milliseconds: 300),
    firstChild: first,
    secondChild: second,
    crossFadeState: fade ? CrossFadeState.showFirst : CrossFadeState.showSecond,
  );
}
