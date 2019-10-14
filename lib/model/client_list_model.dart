import 'dart:convert';

Clients clientListModelFromJson(String str) {
  return Clients.fromJson(str);
}

class Clients {
  List<Datum> data;

  Clients({
    this.data,
  });

  factory Clients.fromJson(String str) => Clients.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Clients.fromMap(Map<String, dynamic> json) => Clients(
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
  String name;
  String email;
  String phoneNumber;
  String photoUrl;
  String uid;

  Datum({
    this.name,
    this.email,
    this.phoneNumber,
    this.photoUrl,
    this.uid,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
        photoUrl: json["photoUrl"] == null ? null : json["photoUrl"],
        uid: json["uid"] == null ? null : json["uid"],
      );

  Map<String, dynamic> toMap() => {
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "phoneNumber": phoneNumber == null ? null : phoneNumber,
        "photoUrl": photoUrl == null ? null : photoUrl,
        "uid": uid == null ? null : uid,
      };
}
