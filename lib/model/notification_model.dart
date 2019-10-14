import 'dart:convert';

import 'package:flutter_native_timezone/generated/i18n.dart';

NotificationModel notificationModelFromJson(String str) {
  final jsonData = jsonDecode(str);
  return NotificationModel.fromJson(jsonData);
}

class NotificationModel {
  List<String> key;
  List<String> description;
  List<String> name;
  List<DateTime> date;
  List<DateTime> time;

  NotificationModel({
    this.key,
    this.description,
    this.name,
    this.date,
    this.time
  });

  factory NotificationModel.fromJson(Map<String, dynamic> parsedJson) {
    var keyFromJson = parsedJson['key'];
    var descriptionFromJson = parsedJson['description'];
    var nameFromJson = parsedJson['name'];
    var dateFromJson = parsedJson['date']; // toDate
    var timeFromJson = parsedJson['time']; // toTime

    var keyList = new List<String>.from(keyFromJson);
    var descriptionList = new List<String>.from(descriptionFromJson);
    var nameList = new List<String>.from(nameFromJson);
    var dateList = new List<DateTime>.from(dateFromJson);
    var timeList = new List<DateTime>.from(timeFromJson);

    return new NotificationModel(
      key: keyList,
      description: descriptionList,
      name: nameList,
      date: dateList,
      time: timeList
    );
  }
}
