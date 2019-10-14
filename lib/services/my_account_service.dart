import 'package:flutter_app/model/my_account_model.dart';
import 'package:http/http.dart' as http;

String url = 'http://localhost:4000/api/account';
String id = '123';

Future<MyAccountModel> getAccountInfo() async {
  final response = await http.get('$url/$id');
  return myAccountModelFromJson(response.body);
}
