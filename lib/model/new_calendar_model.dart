
import 'dart:convert';

NewCalendarModel newCalendarFromJson(String str) {
  return NewCalendarModel.fromJson(str);
}

class NewCalendarModel {
  List<Datum> data;

  NewCalendarModel({
    this.data,
  });

  factory NewCalendarModel.fromJson(String str) => NewCalendarModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NewCalendarModel.fromMap(Map<String, dynamic> json) => NewCalendarModel(
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toMap())),
  };
}

class Datum {
  String dateInstance;
  String description;
  String clientId;
  String clientName;
  String doctorId;
  String doctorName;
  String issue;

  Datum({
    this.dateInstance,
    this.description,
    this.clientId,
    this.clientName,
    this.doctorId,
    this.doctorName,
    this.issue,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    dateInstance: json["dateInstance"] == null ? null : json["dateInstance"],
    description: json["description"] == null ? null : json["description"],
    clientId: json["clientId"] == null ? null : json["clientId"],
    clientName: json["clientName"] == null ? null : json["clientName"],
    doctorId: json["doctorId"] == null ? null : json["doctorId"],
    doctorName: json["doctorName"] == null ? null : json["doctorName"],
    issue: json["issue"] == null ? null : json["issue"],
  );

  Map<String, dynamic> toMap() => {
    "dateInstance": dateInstance == null ? null : dateInstance,
    "description": description == null ? null : description,
    "clientId": clientId == null ? null : clientId,
    "clientName": clientName == null ? null : clientName,
    "doctorId": doctorId == null ? null : doctorId,
    "doctorName": doctorName == null ? null : doctorName,
    "issue": issue == null ? null : issue,
  };
}
