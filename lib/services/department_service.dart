import 'package:appointment_app/model/department_model.dart';
import 'package:appointment_app/utils/http_client.dart';

Future<Department> getDepartments(HttpClient httpClient) async {
  final response = await httpClient.client.get("/department");
  return Department.fromJson(response.body);
}

Future<Department> getTreatmentTypes(HttpClient httpClient) async {
  final response = await httpClient.client.get("/treatment-type");
  return Department.fromJson(response.body);
}
