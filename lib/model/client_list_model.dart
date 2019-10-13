import 'dart:convert';

ClientListModel clientListModelFromJson(String str) {
  final jsonData = jsonDecode(str);
  return ClientListModel.fromJson(jsonData);
}

class ClientListModel {
  List<String> names;

  ClientListModel({
    this.names
  });

  factory ClientListModel.fromJson(Map<String, dynamic> parsedJson) {
    var namesFromJson = parsedJson['names'];

    return new ClientListModel(
      names: namesFromJson
    );
  }
}