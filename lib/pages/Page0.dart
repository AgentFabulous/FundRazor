import 'package:flutter/material.dart';
import 'package:skarbnicaskarbnika/internal/data.dart';
import 'package:skarbnicaskarbnika/internal/ui_common.dart';
import 'package:skarbnicaskarbnika/internal/common.dart';
import 'dart:async';

bool isDone = false;
var page0Interactive;

class Page0 extends StatefulWidget {
  @override
  _Page0 createState() {
    page0Interactive = new _Page0();
    return page0Interactive;
  }
}

class _Page0 extends State<Page0> {
  List<Widget> cards;
  final listsKey = GlobalKey<_Page0>();

  void triggerSetState() {
    setState((){
      cards = buildTiles(isDone, null);
    });
  }

  @override
  Widget build(BuildContext context) {
    cards = buildTiles(isDone,null);
    var column = new Column(
      key: listsKey,
      children: cards,
    );

    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text("Ongoing"),
      ),
      body: new Container(
        padding: const EdgeInsets.only(bottom: 2.0),
        child: new Container(
          child: new SingleChildScrollView(child: column),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
          onPressed: () {
            _fabMenuBuilder(context, new StatefulDialog()).then((Null n) {
              setState(() {
                cards = buildTiles(isDone,null);
              });
            });
          },
          child: new Icon(Icons.add)),
    );
  }
}

Future<Null> _fabMenuBuilder(BuildContext context, Widget child) async {
  return showDialog<Null>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => child);
}


class StatefulDialog extends StatefulWidget {
  _StatefulDialog createState() => new _StatefulDialog();
}

class _StatefulDialog extends State<StatefulDialog> {
  DateTime _date = new DateTime.now();
  String _name;
  double _amount;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      title: new Text('Add Item'),
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
                                return 'Please enter an amount';
                              } else {
                                _name = value;
                              }
                            }),
                      ),
                      new Container(
                        child: new TextFormField(
                            decoration: InputDecoration(
                              hintText: "Amount",
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter an amount';
                              } else {
                                _amount = double.parse(value);
                              }
                            }),
                      ),
                      new Padding(padding: EdgeInsets.all(1.0)),
                    ],
                  )),
            ]),
            new Padding(padding: EdgeInsets.all(10.0)),
            new MaterialButton(
              color: Colors.red,
              textColor: Colors.white,
              minWidth: 2.0,
              child: new Text("Deadline"),
              onPressed: () => _selectDate(context),
            ),
            new Padding(padding: EdgeInsets.all(5.0)),
            new Text(simpleDate(_date), textAlign: TextAlign.center),
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
              debugPrint("Data valid!" +
                  "\nName: " +
                  _name +
                  "\nAmount: " +
                  _amount.toString() +
                  "\nDate: " +
                  _date.toString());
              lists.addToList(new Lists(_name, _amount, _date));
              writeData();
            }
          },
        ),
      ],
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: new DateTime(DateTime.now().year - 100),
        lastDate: new DateTime(DateTime.now().year + 100));

    if (picked != null) {
      print("Date Selected $_date");
      setState(() {
        _date = picked;
      });
    }
  }
}
