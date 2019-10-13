class NewClientModel {
  String name;
  String address;
  String email;
  DateTime dateOfBirth;

  NewClientModel({
    this.name,
    this.address,
    this.email,
    this.dateOfBirth
  });

  factory NewClientModel.fromJson(Map<String, dynamic> parsedJson) {
    var nameFromJson = parsedJson['name'];
    var addressFromJson = parsedJson['address'];
    var emailFromJson = parsedJson['email'];
    var dateOfBirthFromJson = parsedJson['dateOfBirth'];

    return new NewClientModel(
      name: nameFromJson,
      address: addressFromJson,
      email: emailFromJson,
      dateOfBirth: dateOfBirthFromJson
    );
  }
}
