import 'package:after_layout/after_layout.dart';
import 'package:appointment_app/components/action_complete.dart';
import 'package:appointment_app/model/appointment_model.dart';
import 'package:appointment_app/services/appointment_service.dart';
import 'package:appointment_app/utils/http_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppointmentInfo extends StatefulWidget {
  final String appointmentId;
  AppointmentInfo({this.appointmentId});

  @override
  _AppointmentInfoState createState() => _AppointmentInfoState();
}

class _AppointmentInfoState extends State<AppointmentInfo>
    with AfterLayoutMixin<AppointmentInfo> {
  Future _future;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Appointment status"),
      ),
      body: FutureBuilder<AppointmentInfoModel>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Text("Error: " + snapshot.error.toString());
          }

          String currentStatus;

          print(snapshot.data.childActivityInstances.first.activityId);

          switch (snapshot.data.childActivityInstances.first.activityId) {
            case "Task_1gqwpwv":
              currentStatus = "Waiting for client";
              break;
            case "Task_0knnp4t":
              currentStatus = "Waiting for doctor";
              break;
            case "Task_0xuytw0":
              currentStatus = "Waiting for doctor to complete status";
              break;
            case "IntermediateThrowEvent_08koyuz":
              currentStatus = "Waiting for appointnment";
              break;
            case "Complete":
              currentStatus = "Completed";
              break;
            default:
              currentStatus = "Unknown";
          }

          return ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Current status"),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      currentStatus,
                      style: theme.textTheme.display1,
                    ),
                  ],
                ),
              ),
              const Divider(),
              snapshot.data.childActivityInstances.first.activityId !=
                          "Complete" &&
                      snapshot.data.childActivityInstances.first.activityId !=
                          "IntermediateThrowEvent_08koyuz"
                  ? Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text("Action pending"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Column(
                            children:
                                snapshot.data.childActivityInstances.map((res) {
                              return ActionComplete(
                                model: res,
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    )
                  : Container()
            ],
          );
        },
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    setState(() {
      _future =
          getAppointmentInfo(HttpClient.of(context), this.widget.appointmentId);
    });
  }
}
