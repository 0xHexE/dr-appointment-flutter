import 'dart:async';

import 'package:appointment_app/model/new_calendar_model.dart';
import 'package:appointment_app/services/new_calender_service.dart';
import 'package:appointment_app/utils/http_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewCalendar extends StatefulWidget {
  @override
  _NewCalendarState createState() => _NewCalendarState();
}

class _NewCalendarState extends State<NewCalendar> {
  final StreamController _streamController =
      StreamController<NewCalendarModel>();

  @override
  void dispose() {
    // TODO: implement dispose
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () async {
              setState(() {});
              return null;
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: getAppointments(HttpClient.of(context)),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('error');
          }

          if (!snapshot.hasData) {
            return Text('No data ' + snapshot.data.toString());
          }

          return ListView.builder(
            itemCount: snapshot.data.data.length,
            itemBuilder: (context, i) {
              return Card(
                  child: Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                      child: Text(snapshot.data.data[i].clientName),
                    ),
                    title: Text(snapshot.data.data[i].clientName),
                    subtitle: Text(snapshot.data.data[i].issue),
                  ),
                  ButtonTheme.bar(
                    child: ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          child: Text('Show Appointment'),
                          onPressed: () async {
                            await showDialog(
                                context: context,
                                builder: (context) {
                                  return SimpleDialog(
                                    children: <Widget>[
                                      ListView(
                                        shrinkWrap: true,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Padding(
                                                child: Icon(Icons.person),
                                                padding: EdgeInsets.all(20),
                                              ),
                                              Text(snapshot
                                                  .data.data[i].clientName)
                                            ],
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Padding(
                                                child:
                                                    Icon(Icons.local_hospital),
                                                padding: EdgeInsets.all(20),
                                              ),
                                              Text(snapshot
                                                  .data.data[i].doctorName)
                                            ],
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Padding(
                                                child:
                                                    Icon(Icons.report_problem),
                                                padding: EdgeInsets.all(20),
                                              ),
                                              Text(snapshot.data.data[i].issue)
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  );
                                });
                          },
                        )
                      ],
                    ),
                  )
                ],
              ));
            },
          );
        },
      ),
    );
  }
}
