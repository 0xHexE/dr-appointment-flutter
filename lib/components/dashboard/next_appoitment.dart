import 'package:appointment_app/model/dashboard_model.dart';
import 'package:appointment_app/pages/appointment_info.dart';
import 'package:appointment_app/services/dashboard_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppointmentsViewer extends StatelessWidget {
  final int fromDate;
  final int toDate;

  AppointmentsViewer({
    @required this.fromDate,
    @required this.toDate,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getNextAppointments(context, this.fromDate, this.toDate),
      builder: (BuildContext context, AsyncSnapshot<NextAppointment> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }

          if (snapshot.data.data.length == 0) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "No appointments available today",
                ),
              ),
            );
          }

          return Column(
            children: snapshot.data.data.map(
              (res) {
                return ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AppointmentInfo(
                          appointmentId: res.processId,
                        ),
                      ),
                    );
                  },
                  leading: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.black54,
                    child: Icon(
                      Icons.calendar_today,
                    ),
                  ),
                  title: Text(
                    res.clientEntity.name,
                  ),
                  subtitle: Text(
                    res.issue,
                  ),
                );
              },
            ).toList(),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
