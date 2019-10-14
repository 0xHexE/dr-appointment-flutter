import 'dart:convert';
import 'dart:ffi';

import 'package:flutter_native_timezone/generated/i18n.dart';

NotificationModel notificationModelFromJson(String str) {
  final jsonData = jsonDecode(str);
  if (jsonData.isEmpty) {
    return null;
  }else {
    return NotificationModel.fromJson(jsonData['data']);
  }
}

class NotificationModel {
  List<notifications> notification;

  NotificationModel({
    this.notification
  });

  factory NotificationModel.fromJson(List<notifications> parsedJson) {

    if (parsedJson == null) {
      return null;
    }

    var n = parsedJson.toList();

    return new NotificationModel(
        notification: n
    );
  }
}

class notifications {
  String key;
  String description;
  String name;
  DateTime date;
  DateTime time;

  notifications({
    this.key,
    this.description,
    this.name,
    this.date,
    this.time
  });

  factory notifications.fromJson(Map<String, dynamic> parsedJson) {
    var keyFromJson = parsedJson['key'];
    var nameFromJson = parsedJson['name'];
    var descriptionFromJson = parsedJson['description'];
    var dateFromJson = DateTime.fromMicrosecondsSinceEpoch(parsedJson['date'] * 1000);
    var timeFromJson = DateTime.fromMicrosecondsSinceEpoch(parsedJson['time'] * 1000);

    return new notifications(
      key: keyFromJson,
      name: nameFromJson,
      description: descriptionFromJson,
      date: dateFromJson,
      time: timeFromJson
    );
  }
}
