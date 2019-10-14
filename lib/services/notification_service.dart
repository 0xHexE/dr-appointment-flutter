import 'package:appointment_app/model/notification_model.dart';
import 'package:http/http.dart' as http;

String url = 'http://www.mocky.io/v2/5da416ed2f00006b008a093d';
String id = '123';

Future<NotificationModel> getNotifications() async {
  final response = await http.get('$url');
  return notificationModelFromJson(response.body);
}
