import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:appointment_app/services/new_appointment_service.dart';
import 'package:intl/intl.dart';

class NewAppointment extends StatefulWidget {
  @override
  _NewAppointmentState createState() => _NewAppointmentState();
}

class _NewAppointmentState extends State<NewAppointment> {
  final dateFormat = DateFormat("yyyy-MM-dd");
  final timeFormat = DateFormat("HH:mm");

  var name;
  var date;
  var time;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'New Appointment',
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            color: Colors.black,
            icon: Icon(Icons.arrow_back),
            onPressed: () { },
          ),
          backgroundColor: Colors.white,
        ),
      body: Center (
        child: ListView(
          padding: EdgeInsets.all(10),
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                filled: true,
                labelText: 'Name'
              ),
              onChanged: (text) {
                name = text;
              },
            ),
            DateTimeField(
              decoration: InputDecoration(
                filled: true,
                labelText: 'Pick Date'
              ),
              format: dateFormat,
              onShowPicker: (context, currentValue ) {
                return showDatePicker(
                    context: context,
                    firstDate: DateTime(1900),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2100)
                );
              },
              onChanged: (dateText) {
                date = dateText;
              },
            ),
            DateTimeField(
              decoration: InputDecoration(
                filled: true,
                labelText: 'Pick Time'
              ),
              format: timeFormat,
              onShowPicker: (context, currentValue) async {
                final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now())
                );
                return DateTimeField.convert(time);
              },
              onChanged: (timeText) {
                time = timeText;
              },
            )
          ].map((res) {
            return Padding(
              child: res,
              padding: EdgeInsets.fromLTRB(0, 6.0, 0.0, 6.0),
            );
          }).toList(),
        ),
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            var parsedDate = DateTime.parse(date);
            var parsedTime = DateTime.parse(time);

            final res = await addNewAppointment(
                name,
                parsedDate.millisecondsSinceEpoch,
                parsedTime.millisecondsSinceEpoch
            );

            if (res.statusCode == 200) {
              return Center (
                child: AlertDialog(
                  title: Text("Successful"),
                  content: Text("New Appointment Added"),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () { Navigator.of(context).pop(); },
                        child: Text("Close")
                    )
                  ],
                ),
              );
            }else {
              return Center (
                child: AlertDialog(
                  title: Text("Error Adding "),
                  content: Text("Check Internet Connection"),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () { Navigator.of(context).pop(); },
                        child: Text("Close")
                    )
                  ],
                ),
              );
            }
          },
          isExtended: true,
          child: Icon(Icons.save),
        ),
    );
  }
}
