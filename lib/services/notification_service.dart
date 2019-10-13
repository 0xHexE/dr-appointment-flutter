
import 'package:flutter_app/model/notification_model.dart';
import 'package:http/http.dart' as http;

String url = 'http://localhost:4000/api/notifications';
String id = '123';

Future<NotificationModel> getNotifications() async {
  final response = await http.get('$url/$id');
  return notificationModelFromJson(response.body);
}
