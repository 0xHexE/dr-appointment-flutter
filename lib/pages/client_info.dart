import 'package:after_layout/after_layout.dart';
import 'package:appointment_app/model/user_info_model.dart';
import 'package:appointment_app/pages/appointment_info.dart';
import 'package:appointment_app/services/errro_handler.dart';
import 'package:appointment_app/utils/http_client.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ClientInfo extends StatefulWidget {
  final String clientId;

  ClientInfo({@required this.clientId});

  @override
  _ClientInfoState createState() => _ClientInfoState();
}

class _ClientInfoState extends State<ClientInfo>
    with AfterLayoutMixin<ClientInfo> {
  final String clientId;
  Future<UserInfo> data;

  _ClientInfoState({this.clientId});

  @override
  Widget build(BuildContext context) {
    final f = new DateFormat('dd-MM-yyyy hh:mm');
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
      body: FutureBuilder<UserInfo>(
        future: data,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return handleError(context, snapshot.error);
          }

          final appoitnment = snapshot.data.data.appointments.map((res) {
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
              leading: Icon(Icons.calendar_today),
              title: Text(res.issue),
              subtitle: Text(
                f.format(
                  DateTime.parse(
                    res.date,
                  ),
                ),
              ),
            );
          }).toList();

          return ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  snapshot.data.data.user.name,
                  style: theme.textTheme.title,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                ),
                child: Text(
                  snapshot.data.data.user.email,
                ),
              ),
              Divider(),
              // TODO: BREAKING LAW OF THE MATERIAL
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("Appointment History"),
              ),
              appoitnment.length == 0
                  ? Padding(
                      child: Text("No appointments found"),
                      padding: EdgeInsets.all(16.0),
                    )
                  : Container(),
              ...appoitnment,
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text("Edit"),
        icon: Icon(Icons.edit),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    setState(() {
      data = getData(context);
    });
  }

  Future<UserInfo> getData(context) async {
    final response = await HttpClient.of(context)
        .client
        .get("/admin/user-info/" + this.widget.clientId);
    return UserInfo.fromJson(response.body);
  }
}
