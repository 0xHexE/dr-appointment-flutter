import 'dart:async';

import 'package:appointment_app/model/new_calendar_model.dart';
import 'package:appointment_app/utils/http_client.dart';

import 'package:http/http.dart' as http;

final StreamController stateController = StreamController<NewCalendarModel>();

Future<NewCalendarModel> getAppointmentByDate(HttpClient httpClient, DateTime date) async {

  //final epochDate = date.millisecondsSinceEpoch;
  // final response = await httpClient.client.get("/appointments");
  final response = await http.get('http://192.168.1.4:4000/appointments');

  if (response.statusCode != 200) {
    stateController.addError('Failed to get data');
  }

  stateController.add(
      NewCalendarModel.fromJson(response.body)
  );

  var a = NewCalendarModel.fromJson(response.body);
  return NewCalendarModel.fromJson(response.body);

}

Future<NewCalendarModel> getAppointments(HttpClient httpClient) async {
  final response = await httpClient.client.get("/appointments");

  if (response.statusCode != 200) {
    return null;
  }

  return NewCalendarModel.fromJson(response.body);
}
