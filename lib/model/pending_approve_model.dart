import 'dart:convert';

class PendingApproveUsers {
  List<Datum> data;

  PendingApproveUsers({
    this.data,
  });

  factory PendingApproveUsers.fromJson(String str) =>
      PendingApproveUsers.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PendingApproveUsers.fromMap(Map<String, dynamic> json) =>
      PendingApproveUsers(
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
  String id;
  Value value;

  Datum({
    this.id,
    this.value,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        value: json["value"] == null ? null : Value.fromMap(json["value"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "value": value == null ? null : value.toMap(),
      };
}

class Value {
  String dateOfBirth;
  String uid;
  String description;
  String email;
  String address;
  String mobile;
  String name;

  Value({
    this.dateOfBirth,
    this.uid,
    this.description,
    this.email,
    this.address,
    this.mobile,
    this.name,
  });

  factory Value.fromJson(String str) => Value.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Value.fromMap(Map<String, dynamic> json) => Value(
        dateOfBirth: json["DateOfBirth"] == null ? null : json["DateOfBirth"],
        uid: json["uid"] == null ? null : json["uid"],
        description: json["Description"] == null ? null : json["Description"],
        email: json["Email"] == null ? null : json["Email"],
        address: json["Address"] == null ? null : json["Address"],
        mobile: json["Mobile"] == null ? null : json["Mobile"],
        name: json["Name"] == null ? null : json["Name"],
      );

  Map<String, dynamic> toMap() => {
        "DateOfBirth": dateOfBirth == null ? null : dateOfBirth,
        "uid": uid == null ? null : uid,
        "Description": description == null ? null : description,
        "Email": email == null ? null : email,
        "Address": address == null ? null : address,
        "Mobile": mobile == null ? null : mobile,
        "Name": name == null ? null : name,
      };
}
