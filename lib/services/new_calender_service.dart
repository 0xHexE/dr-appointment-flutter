import 'dart:async';

import 'package:appointment_app/model/new_calendar_model.dart';
import 'package:appointment_app/utils/http_client.dart';

import 'package:http/http.dart' as http;

Future<NewCalendarModel> getAppointmentByDate(
    HttpClient httpClient,
    DateTime date) async {

  if (httpClient == null) {
    return null;
  }

  final unixDate = date.millisecondsSinceEpoch == null
      ? null : date.millisecondsSinceEpoch;

  final response = await httpClient.client.get("/appointments/$unixDate");

  // final response = await http.get('http://www.mocky.io/v2/5daac2863100002d00becd9e');
  // uncomment it if want to test with dummy data


  if (response.statusCode != 200) {
    return null;
  }

  return NewCalendarModel.fromJson(response.body);
}

Future<NewCalendarModel> getAppointments(HttpClient httpClient) async {
  final response = await httpClient.client.get("/appointments");

  if (response.statusCode != 200) {
    return null;
  }

  return NewCalendarModel.fromJson(response.body) ;
}
