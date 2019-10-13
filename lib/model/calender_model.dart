import 'dart:convert';

CalenderModel calenderModelFromJson(String str) {
  final jsonData = jsonDecode(str);
  return CalenderModel.fromJson(jsonData);
}

class CalenderModel {
  DateTime date;
  List<String> appointment;
  List<String> description;

  CalenderModel({this.date, this.appointment, this.description});

  factory CalenderModel.fromJson(Map<String, dynamic> parsedJson) {
    var datefromJson = parsedJson['date']; //.toDate or something
    var appointmentsFromJson = parsedJson['appointment'];
    var descriptionFromJson = parsedJson['description'];

    return new CalenderModel(
        date: datefromJson,
        appointment: appointmentsFromJson,
        description: descriptionFromJson);
  }
}
