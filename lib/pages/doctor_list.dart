import 'package:appointment_app/services/doctor_list_service.dart';
import 'package:appointment_app/utils/http_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DoctorList extends StatefulWidget {
  @override
  _DoctorListState createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Doctors'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: FutureBuilder(
        future: getDoctors(
          HttpClient.of(context),
        ),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }

          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
              itemCount: snapshot.data.data.length,
              itemBuilder: (context, i) {
                return Column(
                  children: <Widget>[
                    Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(snapshot.data.data[i].name),
                        ),
                        title: Text(snapshot.data.data[i].name),
                        subtitle: Text(snapshot.data.data[i].email),
                      ),
                    ),
                  ],
                );
              });
        },
      ),
    );
  }
}
