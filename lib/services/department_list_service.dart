
import 'package:appointment_app/model/department_list_model.dart';
import 'package:appointment_app/utils/http_client.dart';

Future<DepartmentListModel> getDepartmentList(HttpClient httpClient) async {
  final response = await httpClient.client.get("/admin/departments");
  return DepartmentListModel.fromJson(response.body);
}
