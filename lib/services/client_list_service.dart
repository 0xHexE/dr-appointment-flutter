import 'package:flutter_app/model/client_list_model.dart';
import 'package:http/http.dart' as http;

String url = 'http://localhost:4000/api/clients';
String id = '123';

Future<ClientListModel> getClients() async {
  final response = await http.get(url);
  return clientListModelFromJson(response.body);
}
