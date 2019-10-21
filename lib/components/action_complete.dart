import 'dart:convert';

import 'package:after_layout/after_layout.dart';
import 'package:appointment_app/model/appointment_model.dart';
import 'package:appointment_app/model/appointment_submit_client_model.dart';
import 'package:appointment_app/utils/http_client.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ActionComplete extends StatefulWidget {
  final AppointmentInfoModel model;

  ActionComplete({@required this.model});

  @override
  _ActionCompleteState createState() => _ActionCompleteState();
}

class _ActionCompleteState extends State<ActionComplete> {
  @override
  Widget build(BuildContext context) {
    Widget action;
    HttpClient httpClient;

    switch (this.widget.model.activityId) {
      case "Task_1gqwpwv":
        action = ActionCompleteClientConfirm(
          processId: widget.model.processInstanceId,
        );
        break;
      case "IntermediateThrowEvent_08koyuz":
        action = Text("Waiting for the appoinment day");
        break;
      case "Task_0xuytw0":
        action = ActionDoctorComplete(
          processId: widget.model.processInstanceId,
        );
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black26,
          width: 1.0,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(
            4.0,
          ),
        ),
      ),
      child: Column(
        children: <Widget>[
          action,
        ],
      ),
    );
  }
}

class ActionDoctorComplete extends StatefulWidget {
  final String processId;

  ActionDoctorComplete({this.processId});

  @override
  _ActionDoctorCompleteState createState() => _ActionDoctorCompleteState();
}

class _ActionDoctorCompleteState extends State<ActionDoctorComplete> {
  void isApprove(bool value) {
    HttpClient.of(context)
        .client
        .post("/appointment/task/complete/is-arrived/" + this.widget.processId,
            body: json.encode({"isClientArrived": value}))
        .then((res) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Successfully submitted"),
      ));
      Navigator.of(context).pop();
    }).catchError((res) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Something went wrong"),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("User arrived?"),
        ),
        ButtonBar(
          children: <Widget>[
            RaisedButton(
              child: Text("Not arrived"),
              onPressed: () {
                isApprove(false);
              },
            ),
            RaisedButton(
              child: Text("Arrived"),
              onPressed: () {
                isApprove(true);
              },
            ),
          ],
        )
      ],
    );
  }
}

class ActionCompleteClientConfirm extends StatefulWidget {
  final String processId;

  ActionCompleteClientConfirm({this.processId});

  @override
  _ActionCompleteClientConfirmState createState() =>
      _ActionCompleteClientConfirmState();
}

class _ActionCompleteClientConfirmState
    extends State<ActionCompleteClientConfirm>
    with AfterLayoutMixin<ActionCompleteClientConfirm> {
  bool available = false;
  final dateFormat = DateFormat("dd-MM-yyyy");
  final timeFormat = DateFormat("HH:mm");
  final _timeController = TextEditingController();
  final _dateController = TextEditingController();
  final _textController = TextEditingController();
  Future _future;

  @override
  void dispose() {
    _timeController.dispose();
    _dateController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  void afterFirstLayout(BuildContext context) async {
    setState(() {
      _future = loadData();
    });
  }

  Future<ClientApprove> loadData() async {
    final response = await HttpClient.of(context)
        .client
        .get("/appointment/task/variables/" + this.widget.processId);
    return ClientApprove.fromJson(response.body);
  }

  Future approve() async {
    final body = json.encode({"isClientAvailable": true});

    await HttpClient.of(context)
        .client
        .post(
            "/appointment/task/complete/client-approve/" +
                this.widget.processId,
            body: body)
        .then((res) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Successfully submitted"),
      ));
      Navigator.of(context).pop();
    }).catchError((res) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Something went wrong"),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FutureBuilder<ClientApprove>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }

        return Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Are you available? On " + snapshot.data.data.date,
                style: theme.textTheme.body2,
              ),
              Switch(
                onChanged: (bool value) {
                  setState(() {
                    available = value;
                  });
                },
                value: available,
              ),
              !available
                  ? TextFormField(
                      decoration: InputDecoration(
                        labelText: "Note",
                        filled: true,
                      ),
                      controller: _textController,
                    )
                  : Container(),
              !available
                  ? Column(
                      children: <Widget>[
                        DateTimeField(
                          decoration:
                              InputDecoration(labelText: 'Available Date'),
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
                          decoration: InputDecoration(
                              filled: true, labelText: 'Available Time'),
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
                      ],
                    )
                  : Container(),
              ButtonBar(
                children: <Widget>[
                  RaisedButton(
                    child: Text("Process"),
                    onPressed: () {
                      approve();
                    },
                  )
                ],
              )
            ].map((res) {
              return Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                child: res,
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
