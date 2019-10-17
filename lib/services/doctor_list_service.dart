import 'package:appointment_app/model/doctor_list_model.dart';
import 'package:appointment_app/utils/http_client.dart';

Future<AllDoctors> getDoctors(HttpClient httpClient) async {
  final response = await httpClient.client.get("/doctors");
  return allDoctorsFromJson(response.body);
}