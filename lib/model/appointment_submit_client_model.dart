import 'dart:convert';

class ClientApprove {
  Data data;

  ClientApprove({
    this.data,
  });

  factory ClientApprove.fromJson(String str) =>
      ClientApprove.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ClientApprove.fromMap(Map<String, dynamic> json) => ClientApprove(
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data == null ? null : data.toMap(),
      };
}

class Data {
  String assignee;
  String description;
  String issue;
  String client;
  int time;
  String id;
  String date;

  Data({
    this.assignee,
    this.description,
    this.issue,
    this.client,
    this.time,
    this.id,
    this.date,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        assignee: json["Assignee"] == null ? null : json["Assignee"],
        description: json["Description"] == null ? null : json["Description"],
        issue: json["Issue"] == null ? null : json["Issue"],
        client: json["client"] == null ? null : json["client"],
        time: json["Time"] == null ? null : json["Time"],
        id: json["ID"] == null ? null : json["ID"],
        date: json["Date"] == null ? null : json["Date"],
      );

  Map<String, dynamic> toMap() => {
        "Assignee": assignee == null ? null : assignee,
        "Description": description == null ? null : description,
        "Issue": issue == null ? null : issue,
        "client": client == null ? null : client,
        "Time": time == null ? null : time,
        "ID": id == null ? null : id,
        "Date": date == null ? null : date,
      };
}
