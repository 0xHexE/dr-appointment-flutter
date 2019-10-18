import 'dart:async';

import 'package:appointment_app/model/doctor_list_model.dart';
import 'package:appointment_app/services/doctor_list_service.dart';
import 'package:appointment_app/utils/http_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DoctorList extends StatefulWidget {
  @override
  _DoctorListState createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  final StreamController _streamController = StreamController<AllDoctors>();

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
            return Text(
              "Error: ${snapshot.error}",
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
                return Column(
                  children: <Widget>[
                    Card(
                        child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: CircleAvatar(
                            child: Text(snapshot.data.data[i].name),
                          ),
                          title: Text(snapshot.data.data[i].name),
                          subtitle: Text(snapshot.data.data[i].email),
                        ),
                        ButtonTheme.bar(
                          child: ButtonBar(
                            children: <Widget>[
                              FlatButton(
                                child: Text('Show Inforamtion'),
                                onPressed: () async {
                                  await showDialog(
                                      context: context,
                                      builder: (context) {
                                        return SimpleDialog(
                                          title: Text('Information'),
                                          children: <Widget>[
                                            ListView(
                                              shrinkWrap: true,
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Padding(
                                                      child: Icon(Icons.person),
                                                      padding:
                                                          EdgeInsets.all(20),
                                                    ),
                                                    Text(
                                                        snapshot
                                                            .data.data[i].name,
                                                        textAlign:
                                                            TextAlign.center),
                                                    Divider()
                                                  ],
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Padding(
                                                      child: Icon(Icons.home),
                                                      padding:
                                                          EdgeInsets.all(20),
                                                    ),
                                                    Text(
                                                        snapshot.data.data[i]
                                                            .address,
                                                        textAlign:
                                                            TextAlign.center),
                                                    Divider()
                                                  ],
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Padding(
                                                      child: Icon(Icons.email),
                                                      padding:
                                                          EdgeInsets.all(20),
                                                    ),
                                                    Text(
                                                        snapshot
                                                            .data.data[i].email,
                                                        textAlign:
                                                            TextAlign.center),
                                                    Divider()
                                                  ],
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Padding(
                                                      child: Icon(Icons
                                                          .mobile_screen_share),
                                                      padding:
                                                          EdgeInsets.all(20),
                                                    ),
                                                    Text(
                                                        snapshot.data.data[i]
                                                                .mobile ??
                                                            'Not available',
                                                        textAlign:
                                                            TextAlign.center),
                                                    Divider()
                                                  ],
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Padding(
                                                      child: Icon(
                                                          Icons.date_range),
                                                      padding:
                                                          EdgeInsets.all(20),
                                                    ),
                                                    Text(
                                                        snapshot.data.data[i]
                                                            .dateOfBirth,
                                                        textAlign:
                                                            TextAlign.center),
                                                    Divider()
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
                    )),
                  ],
                );
              });
        },
      ),
    );
  }
}
