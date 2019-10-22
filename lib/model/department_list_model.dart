import 'dart:convert';

class DepartmentListModel {
  List<Datum> data;

  DepartmentListModel({
    this.data,
  });

  factory DepartmentListModel.fromJson(String str) => DepartmentListModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DepartmentListModel.fromMap(Map<String, dynamic> json) => DepartmentListModel(
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toMap())),
  };
}

class Datum {
  String name;

  Datum({
    this.name,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toMap() => {
    "name": name == null ? null : name,
  };
}
