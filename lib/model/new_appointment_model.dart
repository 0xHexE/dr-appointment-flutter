import 'dart:convert';

String newAppointmentToString(NewAppointmentModel data) {
  final dyn = data.toJson();
  return jsonEncode(dyn);
}

class NewAppointmentModel {
  String name;
  DateTime date;
  DateTime time;

  NewAppointmentModel({
    this.name,
    this.date,
    this.time
  });

  factory NewAppointmentModel.fromJson(Map<String, dynamic> parsedJson) {
    var nameFromJson = parsedJson['name'];
    var dateFromJson = parsedJson['date'];
    var timeFromJson = parsedJson['time'];

    return new NewAppointmentModel(
      name: nameFromJson,
      date: dateFromJson,
      time: timeFromJson
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "date": date,
    "time": time,
  };
}
