library data;

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:json_annotation/json_annotation.dart';
import 'package:path_provider/path_provider.dart';

part 'data.g.dart';

AllLists lists = new AllLists();
final String dataJSON = "data.json";
String fileContents;

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/$dataJSON');
}

Future<int> restoreData() async {
  try {
    final file = await _localFile;
    if (file != null)
      fileContents = await file.readAsString();
    if (fileContents != null) {
      print("Reading...\n" + fileContents);
      Map listsMap = json.decode(fileContents);
      lists = new AllLists.fromJson(listsMap);
    }
  } catch (e) {
    return 1;
  }
  return 0;
}

Future<File> writeData() async {
  final file = await _localFile;
  fileContents = json.encode(lists);
  print("Writing...\n" + fileContents);
  return file.writeAsString(fileContents);
}

@JsonSerializable()
class AllLists extends Object with _$AllListsSerializerMixin {
  List<Lists> allLists = [];

  AllLists();

  void addToList(Lists l) {
    allLists.add(l);
  }

  factory AllLists.fromJson(Map<String, dynamic> json) => _$AllListsFromJson(json);
}

@JsonSerializable()
class Lists extends Object with _$ListsSerializerMixin {
  String name;
  double originalAmount;
  int recalculatedAmount;
  DateTime date;
  List<Person> people;
  bool isDone;

  factory Lists.fromJson(Map<String, dynamic> json) => _$ListsFromJson(json);

  Lists(this.name, this.originalAmount, this.date) {
    people = new List<Person>();
    recalculatedAmount = originalAmount.toInt();
    isDone = false;
  }

  void recalculateAmount() {
    int pLen = people.length;
    recalculatedAmount = originalAmount.toInt() ~/ ((pLen == 0)?1:pLen);
  }

  bool checkStatus() {
    bool isDone = true;
    for (Person p in people) {
      if (!p.hasPaid) {
        isDone = false;
        break;
      }
    }
    this.isDone = isDone;
    return isDone;
  }

  void updatePerson(int index, String name, bool hasPaid) {
    people[index].name = name;
    people[index].hasPaid = hasPaid;
    checkStatus();
  }

  void updatePersonPaid(int index, bool hasPaid) {
    people[index].hasPaid = hasPaid;
    checkStatus();
  }

  void updatePersonName(int index, String name) {
    people[index].name = name;
  }
}

@JsonSerializable()
class Person extends Object with _$PersonSerializerMixin {
  bool hasPaid;
  String name;
  Person(this.name) {
    hasPaid = false;
  }

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
}