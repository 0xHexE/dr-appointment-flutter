import 'package:appointment_app/model/client_list_model.dart';
import 'package:appointment_app/utils/http_client.dart';

Future<Clients> getClients(HttpClient httpClient) async {
  final response = await httpClient.client.get("/clients");
  print(response.body);
  return clientListModelFromJson(response.body);
}
