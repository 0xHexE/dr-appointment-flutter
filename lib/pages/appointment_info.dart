import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppointmentInfo extends StatefulWidget {
  @override
  _AppointmentInfoState createState() => _AppointmentInfoState();
}

class _AppointmentInfoState extends State<AppointmentInfo> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Appointment status"),
      ),
      body: ListView(
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
                  "Waiting for client",
                  style: theme.textTheme.display1,
                ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("Action pending"),
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Container(
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
                  ButtonBar(
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () {},
                        child: Text("Submit"),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
