import 'package:appointment_app/model/appointment_model.dart';
import 'package:appointment_app/utils/http_client.dart';

Future<AppointmentInfoModel> getAppointmentInfo(
    HttpClient httpClient, String id) async {
  final response = await httpClient.client.get("/appointment/info/" + id);
  if (response.body == null || response.body == "") {
    return AppointmentInfoModel(
        childActivityInstances: [AppointmentInfoModel(activityId: "Complete")]);
  }
  return AppointmentInfoModel.fromJson(response.body);
}
