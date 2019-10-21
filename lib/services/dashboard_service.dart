import 'package:appointment_app/model/dashboard_model.dart';
import 'package:appointment_app/utils/http_client.dart';
import 'package:flutter/cupertino.dart';

Future<DashboardData> getDashboardData(BuildContext context) async {
//  final response = await HttpClient.of(context).client.get("/dashboard");
  return DashboardData.fromJson(
    '{"data": [{"chartType": "gauge","data": [{"segment": "Completed","value": 75},{"segment": "Yet to complete","value": 75}]}]}',
  );
}

Future<NextAppointment> getNextAppointments(
    BuildContext context, int from, int to) async {
  final response = await HttpClient.of(context).client.get(
      "/appointment/list?from=" + from.toString() + "&to=" + to.toString());

  return NextAppointment.fromJson(response.body);
}
