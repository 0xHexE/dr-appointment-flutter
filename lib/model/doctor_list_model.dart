import 'dart:convert';

AllDoctors allDoctorsFromJson(String str) {
  return AllDoctors.fromJson(str);
}

class AllDoctors {
  List<Datum> data;

  AllDoctors({
    this.data,
  });

  factory AllDoctors.fromJson(String str) => AllDoctors.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AllDoctors.fromMap(Map<String, dynamic> json) => AllDoctors(
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toMap())),
  };
}

class Datum {
  String name;
  String email;
  String mobile;
  String uid;
  String dateOfBirth;
  String address;

  Datum({
    this.name,
    this.email,
    this.mobile,
    this.uid,
    this.dateOfBirth,
    this.address,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    name: json["name"] == null ? null : json["name"],
    email: json["email"] == null ? null : json["email"],
    mobile: json["mobile"] == null ? null : json["mobile"],
    uid: json["uid"] == null ? null : json["uid"],
    dateOfBirth: json["dateOfBirth"] == null ? null : json["dateOfBirth"],
    address: json["address"] == null ? null : json["address"],
  );

  Map<String, dynamic> toMap() => {
    "name": name == null ? null : name,
    "email": email == null ? null : email,
    "mobile": mobile == null ? null : mobile,
    "uid": uid == null ? null : uid,
    "dateOfBirth": dateOfBirth == null ? null : dateOfBirth,
    "address": address == null ? null : address,
  };
}