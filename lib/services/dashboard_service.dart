import 'package:appointment_app/model/dashboard_model.dart';
import 'package:http/http.dart' as http;

String url = 'http://localhost:4000/api/dashboard';
String id = '123';

Future<DashboardModel> getDashboardData() async {
  final response = await http.get('$url/$id', headers: {});
  return dashboardModelFromJson(response.body);
}
