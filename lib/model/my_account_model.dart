import 'dart:convert';

MyAccountModel myAccountModelFromJson(String str) {
  final jsonData = jsonDecode(str);
  return MyAccountModel.fromJson(jsonData);
}

class MyAccountModel {
  String name;
  String address;
  String email;

  MyAccountModel({
    this.name,
    this.address,
    this.email
  });

  factory MyAccountModel.fromJson(Map<String, dynamic> parsedJson) {
    var nameFromJson = parsedJson['name'];
    var addressFromJson = parsedJson['address'];
    var emailFromJson = parsedJson['email'];

    return new MyAccountModel(
      name: nameFromJson,
      address: addressFromJson,
      email: emailFromJson
    );
  }
}
