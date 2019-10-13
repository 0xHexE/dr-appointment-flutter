
import 'dart:convert';

CalenderModel calenderModelFromJson(String str) {
  final jsonData = jsonDecode(str);
  return CalenderModel.fromJson(jsonData);
}

class CalenderModel {
  DateTime date;
  List<String> names;
  List<String> description;

  CalenderModel({
    this.date,
    this.names,
    this.description
  });

  factory CalenderModel.fromJson(Map<String, dynamic> parsedJson) {
    var dateFromJson = parsedJson['date']; //.toDate or something
    var namesFromJson = parsedJson['appointment'];
    var descriptionFromJson = parsedJson['description'];

    return new CalenderModel(
      date: dateFromJson,
      names: namesFromJson,
      description: descriptionFromJson
    );
  }
}
