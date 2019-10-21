import 'dart:convert';

class UserInfo {
  Data data;

  UserInfo({
    this.data,
  });

  factory UserInfo.fromJson(String str) => UserInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserInfo.fromMap(Map<String, dynamic> json) => UserInfo(
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data == null ? null : data.toMap(),
      };
}

class Data {
  User user;
  List<Appointment> appointments;

  Data({
    this.user,
    this.appointments,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        user: json["user"] == null ? null : User.fromMap(json["user"]),
        appointments: json["appointments"] == null
            ? null
            : List<Appointment>.from(
                json["appointments"].map((x) => Appointment.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "user": user == null ? null : user.toMap(),
        "appointments": appointments == null
            ? null
            : List<dynamic>.from(appointments.map((x) => x.toMap())),
      };
}

class Appointment {
  int id;
  User clientEntity;
  User doctor;
  String date;
  String issue;
  String description;
  int time;
  dynamic status;
  String processId;

  Appointment({
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

  factory Appointment.fromJson(String str) =>
      Appointment.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Appointment.fromMap(Map<String, dynamic> json) => Appointment(
        id: json["id"] == null ? null : json["id"],
        clientEntity: json["clientEntity"] == null
            ? null
            : User.fromMap(json["clientEntity"]),
        doctor: json["doctor"] == null ? null : User.fromMap(json["doctor"]),
        date: json["date"] == null ? null : json["date"],
        issue: json["issue"] == null ? null : json["issue"],
        description: json["description"] == null ? null : json["description"],
        time: json["time"] == null ? null : json["time"],
        status: json["status"],
        processId: json["processId"] == null ? null : json["processId"],
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
        "processId": processId == null ? null : processId,
      };
}

class User {
  String uid;
  dynamic photoUrl;
  String email;
  String userRole;
  String name;
  String mobileNumber;
  String address;
  String dateOfBirth;

  User({
    this.uid,
    this.photoUrl,
    this.email,
    this.userRole,
    this.name,
    this.mobileNumber,
    this.address,
    this.dateOfBirth,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
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
