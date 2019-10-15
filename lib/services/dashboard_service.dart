import 'package:appointment_app/model/dashboard_model.dart';
import 'package:flutter/cupertino.dart';

String url = 'http://localhost:4000/api/dashboard';
String id = '123';

Future<DashboardData> getDashboardData(BuildContext context) async {
//  final response = await HttpClient.of(context).client.get("/dashboard");
  return DashboardData.fromJson(
    '{"data": [{"chartType": "gauge","data": [{"segment": "Completed","value": 75},{"segment": "Yet to complete","value": 75}]}]}',
  );
}

Future<NextAppointment> getNextAppointments(BuildContext context) async {
  return NextAppointment.fromJson(
    '{"data": [{"personName": "Person name","personId": "asas","time": "2019-10-15T19:19:36.937Z","issue": "asokas","description": "Omkar"}]}',
  );
}
