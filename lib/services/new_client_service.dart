
import 'package:appointment_app/model/new_client_model.dart';
import 'package:http/http.dart' as http;

String url = 'http://localhost:4000/api/addClient';

// this and client_add is overlapping
// preferring client_add over this
// do NOT use it