import 'package:appointment_app/model/doctor_list_model.dart';
import 'package:appointment_app/pages/create_user.dart';
import 'package:appointment_app/services/doctor_list_service.dart';
import 'package:appointment_app/utils/http_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DoctorList extends StatefulWidget {
  @override
  _DoctorListState createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  void _showDialog(dynamic snapshot, int i) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text('Information'),
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        child: Icon(Icons.person),
                        padding: EdgeInsets.all(20),
                      ),
                      Text(snapshot.data.data[i].name,
                          textAlign: TextAlign.center),
                      Divider()
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        child: Icon(Icons.home),
                        padding: EdgeInsets.all(20),
                      ),
                      Text(snapshot.data.data[i].address,
                          textAlign: TextAlign.center),
                      Divider()
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        child: Icon(Icons.email),
                        padding: EdgeInsets.all(20),
                      ),
                      Text(snapshot.data.data[i].email,
                          textAlign: TextAlign.center),
                      Divider()
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        child: Icon(Icons.mobile_screen_share),
                        padding: EdgeInsets.all(20),
                      ),
                      Text(snapshot.data.data[i].mobile ?? 'Not available',
                          textAlign: TextAlign.center),
                      Divider()
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        child: Icon(Icons.date_range),
                        padding: EdgeInsets.all(20),
                      ),
                      Text(snapshot.data.data[i].dateOfBirth ?? 'Not available',
                          textAlign: TextAlign.center),
                      Divider()
                    ],
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctors'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CreateUserPage(type: "doctor"),
            ),
          );
        },
        label: Text("New doctor"),
      ),
      body: FutureBuilder<AllDoctors>(
        future: getDoctors(
          HttpClient.of(context),
        ),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(
              "Error: ${snapshot.error}",
            );
          }

          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data.data.length == 0) {
            return Center(
              child: Text("No doctors found"),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data.data.length,
            itemBuilder: (context, i) {
              return ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.person),
                ),
                onTap: () {
                  _showDialog(snapshot, i);
                },
                title: Text(snapshot.data.data[i].name),
                subtitle: Text(snapshot.data.data[i].email),
              );
            },
          );
        },
      ),
    );
  }
}
