import 'package:flutter/material.dart';

import 'appointment_info.dart';

class ClientInfo extends StatefulWidget {
  final String clientId;

  ClientInfo({@required this.clientId});

  @override
  _ClientInfoState createState() => _ClientInfoState();
}

class _ClientInfoState extends State<ClientInfo> {
  final String clientId;

  _ClientInfoState({this.clientId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.white,
        title: Text(
          "Your client",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Name",
              style: theme.textTheme.title,
            ),
          ),
          Divider(),
          // TODO: BREAKING LAW OF THE MATERIAL
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("Appointment History"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AppointmentInfo(),
                ),
              );
            },
            leading: Icon(Icons.calendar_today),
            title: Text("13-Dec-2018"),
            subtitle: Text("Ongoing"),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text("Edit"),
        icon: Icon(Icons.edit),
      ),
    );
  }
}
