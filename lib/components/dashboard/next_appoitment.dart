import 'package:appointment_app/model/dashboard_model.dart';
import 'package:appointment_app/services/dashboard_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NextAppointmentData extends StatelessWidget {
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
                return Padding(
                  padding: EdgeInsets.only(
                    top: 4.0,
                    bottom: 4.0,
                    left: 12.0,
                    right: 12.0,
                  ),
                  child: Card(
                    elevation: 4.0,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          title: Text(
                            "${res.personName}",
                          ),
                          subtitle: Text(
                            '${res.issue}',
                          ),
                          isThreeLine: true,
                        ),
                        ButtonTheme.bar(
                          child: ButtonBar(
                            alignment: MainAxisAlignment.start,
                            children: <Widget>[
                              FlatButton(
                                child: Text("VIEW"),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
