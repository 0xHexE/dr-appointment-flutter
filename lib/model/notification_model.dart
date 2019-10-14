import 'dart:convert';

NotificationModel notificationModelFromJson(String str) {
  final jsonData = jsonDecode(str);
  if (jsonData.isEmpty) {
    return null;
  }else {
    return NotificationModel.fromJson(jsonData);
  }
}

class NotificationModel {
  List<notifications> notification;

  NotificationModel({
    this.notification
  });

  factory NotificationModel.fromJson(Map<String, dynamic> parsedJson) {

    if (parsedJson == null) {
      return null;
    }

    List<notifications> n = new List();
    var parsedDataFromJson = parsedJson['data'];
    for(var i = 0; i < parsedDataFromJson.length; i++) {
      n.add(notifications.fromJson(parsedDataFromJson[i]));
    }

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
