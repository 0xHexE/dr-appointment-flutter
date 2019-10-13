import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:ui';

String clientAddModelToString(ClientAddModel data) {
  final dyn = data.toJson();
  return jsonEncode(dyn);
}

class ClientAddModel {
  String name;
  String address;
  DateTime dateOfBirth;

  ClientAddModel({
    this.name,
    this.address,
    this.dateOfBirth,
  });

  factory ClientAddModel.fromJson(Map<String, dynamic> parsedJson) {
    var nameFromJson = parsedJson['name'];
    var addressFromJson = parsedJson['address'];
    var dateOfBirthFromJson = parsedJson['dateOfBirth']; //toDate

    return new ClientAddModel(
      name: nameFromJson,
      address: addressFromJson,
      dateOfBirth: dateOfBirthFromJson
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "address": address,
    "dateOfBirth": dateOfBirth,
  };
}
