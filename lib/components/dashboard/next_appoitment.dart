import 'package:appointment_app/model/dashboard_model.dart';
import 'package:appointment_app/pages/appointment_info.dart';
import 'package:appointment_app/services/dashboard_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThisDayAppointment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getNextAppointments(context),
      builder: (BuildContext context, AsyncSnapshot<NextAppointment> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return ListView(
            shrinkWrap: true,
            children: snapshot.data.data.map(
              (res) {
                return ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AppointmentInfo(),
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
                    res.personName,
                  ),
                  subtitle: Text(
                    res.issue,
                  ),
                );
              },
            ).toList(),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
