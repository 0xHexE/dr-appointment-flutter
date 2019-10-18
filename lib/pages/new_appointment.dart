import 'dart:convert';

import 'package:appointment_app/model/client_list_model.dart';
import 'package:appointment_app/services/client_list_service.dart';
import 'package:appointment_app/utils/http_client.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewAppointment extends StatefulWidget {
  @override
  _NewAppointmentState createState() => _NewAppointmentState();
}

class _NewAppointmentState extends State<NewAppointment> {
  final dateFormat = DateFormat("yyyy-MM-dd");
  final timeFormat = DateFormat("HH:mm");

  final _issueController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _timeController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeInMinutesController = TextEditingController();

  String clientUid;

  @override
  void dispose() {
    _issueController.dispose();
    _descriptionController.dispose();
    _timeController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _timeInMinutesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _key = GlobalKey<ScaffoldState>();

    return Scaffold(
      appBar: AppBar(
        key: _key,
        title: Text(
          'New Appointment',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: Form(
        child: ListView(
          padding: EdgeInsets.all(10),
          children: <Widget>[
            FutureBuilder(
              future: getClients(HttpClient.of(context)),
              builder: (BuildContext context, AsyncSnapshot<Clients> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  return DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      filled: true,
                      labelText: 'Client',
                    ),
                    items: snapshot.data.data.map((Datum value) {
                      return DropdownMenuItem<String>(
                        value: value.uid,
                        child: new Text(value.name),
                      );
                    }).toList(),
                    value: clientUid,
                    onChanged: (data) {
                      setState(() {
                        clientUid = data;
                      });
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                filled: true,
                labelText: 'Issue',
              ),
              controller: _issueController,
            ),
            TextFormField(
              decoration: InputDecoration(
                filled: true,
                labelText: 'Description',
              ),
              minLines: 3,
              maxLines: 3,
              controller: _descriptionController,
            ),
            DateTimeField(
              decoration: InputDecoration(filled: true, labelText: 'Pick Date'),
              format: dateFormat,
              onShowPicker: (context, currentValue) {
                return showDatePicker(
                  context: context,
                  firstDate: DateTime(1900),
                  initialDate: currentValue ?? DateTime.now(),
                  lastDate: DateTime(2100),
                );
              },
              controller: _dateController,
            ),
            DateTimeField(
              decoration: InputDecoration(filled: true, labelText: 'Pick Time'),
              format: timeFormat,
              controller: _timeController,
              onShowPicker: (context, currentValue) async {
                final time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.fromDateTime(
                    currentValue ?? DateTime.now(),
                  ),
                );
                return DateTimeField.convert(time);
              },
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Time required in minutes',
              ),
              controller: _timeInMinutesController,
            ),
          ].map((res) {
            return Padding(
              child: res,
              padding: EdgeInsets.fromLTRB(0, 6.0, 0.0, 6.0),
            );
          }).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final httpClient = HttpClient.of(context);
          httpClient.client
              .post("/appointment",
                  body: jsonEncode({
                    "date": DateTime.now().millisecondsSinceEpoch,
                    "description": _descriptionController.text,
                    "issue": _issueController.text,
                    "client": clientUid,
                    "time": 60
                  }))
              .then((res) {
            _key.currentState.showSnackBar(SnackBar(
              content: Text(
                  "Success check you notification for further instructions"),
            ));
          }).catchError((res) {
            _key.currentState.showSnackBar(SnackBar(
              content: Text("Error " + res.toString()),
            ));
          });
//          final res = addNewAppointment('test', 'testDate', 'testTime');
        },
        isExtended: true,
        child: Icon(Icons.save),
      ),
    );
  }
}
