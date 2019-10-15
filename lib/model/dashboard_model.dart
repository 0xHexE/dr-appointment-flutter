import 'dart:convert';

class DashboardData {
  List<DashboardDataDatum> data;

  DashboardData({
    this.data,
  });

  factory DashboardData.fromJson(String str) =>
      DashboardData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DashboardData.fromMap(Map<String, dynamic> json) => DashboardData(
        data: json["data"] == null
            ? null
            : List<DashboardDataDatum>.from(
                json["data"].map((x) => DashboardDataDatum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class DashboardDataDatum {
  String chartType;
  List<DatumDatum> data;

  DashboardDataDatum({
    this.chartType,
    this.data,
  });

  factory DashboardDataDatum.fromJson(String str) =>
      DashboardDataDatum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DashboardDataDatum.fromMap(Map<String, dynamic> json) =>
      DashboardDataDatum(
        chartType: json["chartType"] == null ? null : json["chartType"],
        data: json["data"] == null
            ? null
            : List<DatumDatum>.from(
                json["data"].map((x) => DatumDatum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "chartType": chartType == null ? null : chartType,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class DatumDatum {
  String segment;
  int value;

  DatumDatum({
    this.segment,
    this.value,
  });

  factory DatumDatum.fromJson(String str) =>
      DatumDatum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DatumDatum.fromMap(Map<String, dynamic> json) => DatumDatum(
        segment: json["segment"] == null ? null : json["segment"],
        value: json["value"] == null ? null : json["value"],
      );

  Map<String, dynamic> toMap() => {
        "segment": segment == null ? null : segment,
        "value": value == null ? null : value,
      };
}

class NextAppointment {
  List<NextAppointmentDatum> data;

  NextAppointment({
    this.data,
  });

  factory NextAppointment.fromJson(String str) =>
      NextAppointment.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NextAppointment.fromMap(Map<String, dynamic> json) => NextAppointment(
        data: json["data"] == null
            ? null
            : List<NextAppointmentDatum>.from(
                json["data"].map((x) => NextAppointmentDatum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class NextAppointmentDatum {
  String personName;
  String personId;
  DateTime time;
  String issue;
  String description;

  NextAppointmentDatum({
    this.personName,
    this.personId,
    this.time,
    this.issue,
    this.description,
  });

  factory NextAppointmentDatum.fromJson(String str) =>
      NextAppointmentDatum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NextAppointmentDatum.fromMap(Map<String, dynamic> json) =>
      NextAppointmentDatum(
        personName: json["personName"] == null ? null : json["personName"],
        personId: json["personId"] == null ? null : json["personId"],
        time: json["time"] == null ? null : DateTime.parse(json["time"]),
        issue: json["issue"] == null ? null : json["issue"],
        description: json["description"] == null ? null : json["description"],
      );

  Map<String, dynamic> toMap() => {
        "personName": personName == null ? null : personName,
        "personId": personId == null ? null : personId,
        "time": time == null ? null : time.toIso8601String(),
        "issue": issue == null ? null : issue,
        "description": description == null ? null : description,
      };
}
