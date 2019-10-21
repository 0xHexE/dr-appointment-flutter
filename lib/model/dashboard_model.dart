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
  List<Datum> data;

  NextAppointment({
    this.data,
  });

  factory NextAppointment.fromJson(String str) =>
      NextAppointment.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NextAppointment.fromMap(Map<String, dynamic> json) => NextAppointment(
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class Datum {
  int id;
  ClientEntity clientEntity;
  ClientEntity doctor;
  String date;
  String issue;
  String description;
  int time;
  dynamic status;
  String processId;

  Datum({
    this.id,
    this.clientEntity,
    this.doctor,
    this.date,
    this.issue,
    this.description,
    this.time,
    this.status,
    this.processId,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        clientEntity: json["clientEntity"] == null
            ? null
            : ClientEntity.fromMap(json["clientEntity"]),
        doctor: json["doctor"] == null
            ? null
            : ClientEntity.fromMap(json["doctor"]),
        date: json["date"] == null ? null : json["date"],
        issue: json["issue"] == null ? null : json["issue"],
        description: json["description"] == null ? null : json["description"],
        time: json["time"] == null ? null : json["time"],
        status: json["status"],
        processId: json["processId"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "clientEntity": clientEntity == null ? null : clientEntity.toMap(),
        "doctor": doctor == null ? null : doctor.toMap(),
        "date": date == null ? null : date,
        "issue": issue == null ? null : issue,
        "description": description == null ? null : description,
        "time": time == null ? null : time,
        "status": status,
        "processId": processId,
      };
}

class ClientEntity {
  String uid;
  dynamic photoUrl;
  String email;
  String userRole;
  String name;
  String mobileNumber;
  String address;
  String dateOfBirth;

  ClientEntity({
    this.uid,
    this.photoUrl,
    this.email,
    this.userRole,
    this.name,
    this.mobileNumber,
    this.address,
    this.dateOfBirth,
  });

  factory ClientEntity.fromJson(String str) =>
      ClientEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ClientEntity.fromMap(Map<String, dynamic> json) => ClientEntity(
        uid: json["uid"] == null ? null : json["uid"],
        photoUrl: json["photoUrl"],
        email: json["email"] == null ? null : json["email"],
        userRole: json["userRole"] == null ? null : json["userRole"],
        name: json["name"] == null ? null : json["name"],
        mobileNumber:
            json["mobileNumber"] == null ? null : json["mobileNumber"],
        address: json["address"] == null ? null : json["address"],
        dateOfBirth: json["dateOfBirth"] == null ? null : json["dateOfBirth"],
      );

  Map<String, dynamic> toMap() => {
        "uid": uid == null ? null : uid,
        "photoUrl": photoUrl,
        "email": email == null ? null : email,
        "userRole": userRole == null ? null : userRole,
        "name": name == null ? null : name,
        "mobileNumber": mobileNumber == null ? null : mobileNumber,
        "address": address == null ? null : address,
        "dateOfBirth": dateOfBirth == null ? null : dateOfBirth,
      };
}
