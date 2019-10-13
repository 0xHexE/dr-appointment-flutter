
import 'package:flutter_app/model/calender_model.dart';
import 'package:http/http.dart' as http;

String url = 'http://localhost:4000/api/calender';
String id = '123';

Future<CalenderModel> getTodaySchedule() async {
  final response = await http.get('$url/$id/');
  return calenderModelFromJson(response.body);
}
