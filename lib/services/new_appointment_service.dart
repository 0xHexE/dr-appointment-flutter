
import 'dart:io';

import 'package:appointment_app/model/new_appointment_model.dart';
import 'package:http/http.dart' as http;

String url = 'http://localhost:4000/api/addnewappointment';
String id = '123';

Future<http.Response> addNewAppointment(name, date, time) async {
  final response = await http.post('$url',
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: '',
    },
    body: newAppointmentToString(new NewAppointmentModel(
        name: name,
        date: date,
        time: time
    ))
  );

  return response;
}
