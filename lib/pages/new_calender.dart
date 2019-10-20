import 'dart:async';

import 'package:appointment_app/model/new_calendar_model.dart';
import 'package:appointment_app/pages/appointment_info.dart';
import 'package:appointment_app/services/new_calender_service.dart';
import 'package:appointment_app/utils/http_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewCalendar extends StatefulWidget {
  @override
  _NewCalendarState createState() => _NewCalendarState();
}

class _NewCalendarState extends State<NewCalendar> {
  final StreamController _streamController =
      StreamController<NewCalendarModel>();

  final _timeFormat = DateFormat.jm();

  void updateAppointment(DateTime date) async {
    _streamController.add(null);

    final jsonData = await getAppointmentByDate(HttpClient.of(context), date);
    if (jsonData == null) {
      _streamController.addError('Error Getting Data');
    }
    _streamController.add(jsonData);
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100), () {
      updateAppointment(DateTime.now());
    });
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointments'),
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
              final date = await showDatePicker(
                context: context,
                firstDate: DateTime(1900),
                initialDate: DateTime.now(),
                lastDate: DateTime(2100),
              );
              updateAppointment(date);
            },
          )
        ],
      ),
      body: StreamBuilder(
        stream: _streamController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return AlertDialog(
              title: Text('Error'),
              content: Text(snapshot.error.toString()),
            );
          }

          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data.data.length,
            itemBuilder: (context, i) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.black54,
                  child: Icon(
                    Icons.calendar_today,
                  ),
                ),
                onTap: () async {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AppointmentInfo(),
                    ),
                  );
                },
                title: Text(snapshot.data.data[i].clientName),
                subtitle: Text(snapshot.data.data[i].issue),
              );
            },
          );
        },
      ),
    );
  }
}
