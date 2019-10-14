import 'dart:convert';

NotificationModel notificationModelFromJson(String str) {
  final jsonData = jsonDecode(str);
  return NotificationModel.fromJson(jsonData);
}

class NotificationModel {
  List<String> description;
  List<String> name;
  List<DateTime> date;
  List<DateTime> time;

  NotificationModel({
    this.description,
    this.name,
    this.date,
    this.time
  });

  factory NotificationModel.fromJson(Map<String, dynamic> parsedJson) {
    var descriptionFromJson = parsedJson['description'];
    var nameFromJson = parsedJson['name'];
    var dateFromJson = parsedJson['date']; // toDate
    var timeFromJson = parsedJson['time']; //toTime

    return new NotificationModel(
      description: descriptionFromJson,
      name: nameFromJson,
      date: dateFromJson,
      time: timeFromJson
    );
  }
}
