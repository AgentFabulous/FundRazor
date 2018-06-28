import 'package:flutter/material.dart';
import 'dart:async';

class Page0 extends StatefulWidget {
  @override
  _Page0 createState() => new _Page0();
}

class _Page0 extends State<Page0> {
  @override
  Widget build(BuildContext context) {
    final double myTextSize = 30.0;
    final TextStyle myTextStyle =
        new TextStyle(color: Colors.grey, fontSize: myTextSize);
    var column = new Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        new CenteredCard(
          title: new Text(
            "Page0",
            style: myTextStyle,
          ),
        )
      ],
    );

    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text("Ekran główny"),
      ),
      body: new Container(
        padding: const EdgeInsets.only(bottom: 2.0),
        child: new Container(
          child: new SingleChildScrollView(child: column),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
          onPressed: () => _fabMenuBuilder(context, new StatefulDialog()),
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

class CenteredCard extends StatelessWidget {
  final Widget title;

  CenteredCard({this.title});

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
            new Text(
                _date.day.toString() +
                    "/" +
                    _date.month.toString() +
                    "/" +
                    _date.year.toString(),
                textAlign: TextAlign.center),
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
                  "\nName: " + _name +
                  "\nAmount: " + _amount.toString() +
                  "\nDate: " + _date.toString());
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
