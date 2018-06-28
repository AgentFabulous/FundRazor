// GENERATED CODE - DO NOT MODIFY BY HAND

part of data;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllLists _$AllListsFromJson(Map<String, dynamic> json) => new AllLists()
  ..allLists = (json['allLists'] as List)
      ?.map((e) =>
          e == null ? null : new Lists.fromJson(e as Map<String, dynamic>))
      ?.toList();

abstract class _$AllListsSerializerMixin {
  List<Lists> get allLists;
  Map<String, dynamic> toJson() => <String, dynamic>{'allLists': allLists};
}

Lists _$ListsFromJson(Map<String, dynamic> json) => new Lists(
    json['name'] as String,
    (json['originalAmount'] as num)?.toDouble(),
    json['date'] == null ? null : DateTime.parse(json['date'] as String))
  ..recalculatedAmount = json['recalculatedAmount'] as int
  ..people = (json['people'] as List)
      ?.map((e) =>
          e == null ? null : new Person.fromJson(e as Map<String, dynamic>))
      ?.toList()
  ..isDone = json['isDone'] as bool;

abstract class _$ListsSerializerMixin {
  String get name;
  double get originalAmount;
  int get recalculatedAmount;
  DateTime get date;
  List<Person> get people;
  bool get isDone;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'originalAmount': originalAmount,
        'recalculatedAmount': recalculatedAmount,
        'date': date?.toIso8601String(),
        'people': people,
        'isDone': isDone
      };
}

Person _$PersonFromJson(Map<String, dynamic> json) =>
    new Person(json['name'] as String)..hasPaid = json['hasPaid'] as bool;

abstract class _$PersonSerializerMixin {
  bool get hasPaid;
  String get name;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'hasPaid': hasPaid, 'name': name};
}
