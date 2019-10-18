import 'package:appointment_app/model/notification_model.dart';
import 'package:appointment_app/utils/http_client.dart';

// for testing with data OLD
// String url = 'http://www.mocky.io/v2/5da4557b3500003a004a75f7';

String url = 'http://www.mocky.io/v2/5da4ab0935000063004a788a';

// for testing with empty json like {}
// String url = 'http://www.mocky.io/v2/5da4640f35000054004a768b';
String id = '123';

Future<NotificationModel> getNotifications(HttpClient client) async {
  final response = await client.client.get("/notification/");
  print(response.body);
  return notificationModelFromJson(response.body);
}

/*
{
  "data": [
    {"key": "key1", "name": "name1", "description": "desc1", "date": 42325254, "time": 37563935},
    {"key": "key2", "name": "name2", "description": "desc2", "date": 42325254, "time": 37563935},
    {"key": "key3", "name": "name3", "description": "desc3", "date": 42325254, "time": 37563935}
  ]
}
*/
