import 'package:appointment_app/model/client_list_model.dart';
import 'package:appointment_app/model/pending_approve_model.dart';
import 'package:appointment_app/utils/http_client.dart';

Future<Clients> getClients(HttpClient httpClient) async {
  final response = await httpClient.client.get("/admin/users?type=client");
  return clientListModelFromJson(response.body);
}

Future<Clients> getDoctors(HttpClient httpClient) async {
  final response = await httpClient.client.get("/admin/users?type=doctor");
  return clientListModelFromJson(response.body);
}

Future<PendingApproveUsers> getClientsUnApproved(HttpClient httpClient) async {
  final response = await httpClient.client.get("/admin/unapproved-users");
  print(response.body);
  return PendingApproveUsers.fromJson(response.body);
}
