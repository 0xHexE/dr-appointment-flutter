
import 'dart:io';

import 'package:appointment_app/model/client_add_model.dart';
import 'package:http/http.dart' as http;

String url = 'http://localhost:4000/api/addClient';

Future<http.Response> addClient(name, address, dateOfBirth) async {
  final response = await http.post(url,
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: ''
    },
    body: clientAddModelToString(new ClientAddModel(
        name: name,
        address: address,
        dateOfBirth: dateOfBirth
    ))
  );

  return response;
}
