import 'package:flutter/material.dart';
import 'package:skarbnicaskarbnika/internal/data.dart';
import 'package:skarbnicaskarbnika/internal/common.dart';
import 'dart:async';

/// Helper stateless classes
class ListsCard extends StatelessWidget {
  final int index;

  ListsCard(this.index);

  @override
  Widget build(BuildContext context) {
    final double textSize = 20.0;
    final TextStyle textStyle = new TextStyle(fontSize: textSize);
    return new Container(
        padding: const EdgeInsets.only(top: 1.0, left: 15.0, right: 15.0),
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
                        onPressed: () {
                          popupMenuBuilder(context, new DeleteListDialog(index)).then((Null n) {
                            updateStuff();
                          });
                        },
                        child: new Text("Delete",
                            style: new TextStyle(color: Colors.blue))),
                    new FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => new PeoplePage(index)));
                          updateStuff();
                        },
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

/// Helper stateful classes
class PeoplePage extends StatefulWidget {
  final int index;

  PeoplePage(this.index);

  _PeoplePage createState() => new _PeoplePage(this.index);
}

class _PeoplePage extends State<PeoplePage> {
  final int index;

  _PeoplePage(this.index);

  List<Person> _people;

  List<Widget> _buildPeopleInfo(int index) {
    _people = lists.allLists[index].people;
    int _len = _people.length;
    int x = 0;
    List<Widget> peopleList = new List<Widget>(((_len == 0) ? 1 : _len) + 1);
    peopleList[x++] = _headerWidgetGen();
    if (_len == 0) {
      peopleList[x++] = new Padding(padding: EdgeInsets.all(0.0));
    } else {
      for (int i = 0; i < _len; i++) {
        peopleList[x++] = new GestureDetector(
          child: new CheckboxListTile(
              title: new Text(_people[i].name),
              value: _people[i].hasPaid,
              onChanged: (bool val) {
                lists.allLists[index].updatePersonPaid(i, val);
                setState(() {
                  _people = lists.allLists[index].people;
                });
                writeData();
              }),
          onLongPress: () =>
              popupMenuBuilder(context, new DeletePersonDialog(index, i))
                  .then((Null n) => setState(() {
                        _people = lists.allLists[index].people;
                      })),
        );
      }
    }
    return peopleList;
  }

  @override
  void initState() {
    super.initState();
    _people = lists.allLists[index].people;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lists.allLists[index].name),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.add),
            onPressed: () {
              popupMenuBuilder(context, new StatefulPeopleDialog(index))
                  .then((Null n) {
                setState(() {
                  _people = lists.allLists[index].people;
                });
              });
            },
          ),
        ],
      ),
      body: new SingleChildScrollView(
        child: Column(children: _buildPeopleInfo(index)),
      ),
    );
  }

  Widget _headerWidgetGen() {
    int pLen = lists.allLists[index].people.length;
    String everyonePays;
    if (pLen == 0) {
      everyonePays = "Nobody home ¯\\_(ツ)_/¯";
      pLen = 1;
    } else {
      everyonePays = "Everyone pays: " +
          (lists.allLists[index].recalculatedAmount ~/ pLen).toString();
    }
    TextStyle summary = new TextStyle(color: Colors.grey);
    return new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          new Container(
            child: new Text("Goal",
                style: new TextStyle(fontSize: 20.0, color: Colors.grey),
                textAlign: TextAlign.center),
            padding: EdgeInsets.only(top: 60.0),
          ),
          new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                  child: new Text("\$",
                      style: new TextStyle(fontSize: 20.0),
                      textAlign: TextAlign.center),
                  padding: EdgeInsets.only(top: 0.0, bottom: 50.0),
                ),
                new Padding(padding: EdgeInsets.all(2.0)),
                new Container(
                  child: new Text(
                      lists.allLists[index].recalculatedAmount.toString(),
                      style: new TextStyle(fontSize: 50.0),
                      textAlign: TextAlign.center),
                  padding: EdgeInsets.only(top: 20.0, bottom: 50.0),
                ),
              ]),
          new Column(
            children: <Widget>[
              new Text(
                  "Initial target: " +
                      lists.allLists[index].originalAmount.toInt().toString(),
                  style: summary),
              new Text(
                  "Recalculated goal: " +
                      lists.allLists[index].recalculatedAmount.toString(),
                  style: summary),
              new Text(everyonePays, style: summary),
              new Padding(padding: EdgeInsets.all(5.0))
            ],
          )
        ]);
  }
}

class StatefulPeopleDialog extends StatefulWidget {
  final int index;

  StatefulPeopleDialog(this.index);

  _StatefulPeopleDialog createState() => new _StatefulPeopleDialog(index);
}

class _StatefulPeopleDialog extends State<StatefulPeopleDialog> {
  final int index;
  final _formKey = GlobalKey<FormState>();
  String _name;

  _StatefulPeopleDialog(this.index);

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      title: new Text('Add Person'),
      content: new SingleChildScrollView(
        child: new ListBody(
          children: <Widget>[
            Column(children: <Widget>[
              Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Container(
                        child: new TextFormField(
                            decoration: InputDecoration(
                              hintText: "Name",
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter a name';
                              } else {
                                _name = value;
                              }
                            }),
                      ),
                      new Padding(padding: EdgeInsets.all(1.0)),
                    ],
                  )),
            ]),
            new Padding(padding: EdgeInsets.all(10.0)),
          ],
        ),
      ),
      actions: <Widget>[
        new FlatButton(
          child: new Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        new FlatButton(
          child: new Text('Submit'),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              Navigator.of(context).pop();
              lists.allLists[index].addPerson(_name);
              writeData();
            }
          },
        ),
      ],
    );
  }
}

class DeletePersonDialog extends StatelessWidget {
  final int index;
  final int pIndex;

  DeletePersonDialog(this.index, this.pIndex);

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(title: new Text("Delete Person?"), actions: <Widget>[
      new FlatButton(
        child: new Text('No'),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      new FlatButton(
          child: new Text('Yes'),
          onPressed: () {
            lists.allLists[index].deletePerson(pIndex);
            writeData();
            Navigator.of(context).pop();
          }),
    ]);
  }
}


class DeleteListDialog extends StatelessWidget {
  final int index;

  DeleteListDialog(this.index);

  @override
  Widget build(BuildContext context) {
    String _name = lists.allLists[index].name;
    return new AlertDialog(title: new Text("Delete $_name?"), actions: <Widget>[
      new FlatButton(
        child: new Text('No'),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      new FlatButton(
          child: new Text('Yes'),
          onPressed: () {
            lists.allLists.removeAt(index);
            writeData();
            Navigator.of(context).pop();
          }),
    ]);
  }
}
/// Functions
List<Widget> buildTiles(bool isDone, Widget extra) {
  int _len =
      (extra != null) ? (calculateLength(isDone) + 1) : calculateLength(isDone);
  int x = 0;
  List<Widget> tiles = new List<Widget>(_len + 2);
  if (extra != null) {
    tiles[x++] = extra;
  }
  tiles[x++] = new Padding(padding: EdgeInsets.all(15.0));
  for (int i = 0; i < lists.allLists.length; i++) {
    if (isDone) {
      if (lists.allLists[i].isDone) tiles[x++] = new ListsCard(i);
    } else {
      if (!lists.allLists[i].isDone) tiles[x++] = new ListsCard(i);
    }
  }
  tiles[x++] = new Padding(padding: EdgeInsets.all(25.0));
  return tiles;
}

Future<Null> popupMenuBuilder(BuildContext context, Widget child) async {
  return showDialog<Null>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => child);
}
