import 'dart:convert';

import 'package:after_layout/after_layout.dart';
import 'package:appointment_app/model/client_list_model.dart';
import 'package:appointment_app/model/pending_approve_model.dart';
import 'package:appointment_app/services/client_list_service.dart';
import 'package:appointment_app/utils/http_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PendingClientsList extends StatefulWidget {
  @override
  _PendingClientsListState createState() => _PendingClientsListState();
}

class _PendingClientsListState extends State<PendingClientsList>
    with AfterLayoutMixin<PendingClientsList> {
  Future<PendingApproveUsers> _pendingApprove;

  String clientUid;

  void getPendingApprove() {
    setState(() {
      _pendingApprove = getClientsUnApproved(HttpClient.of(context));
    });
  }

  _reloadData() {
    getPendingApprove();
  }

  void _showBottomSheet(dynamic data, String id) {
    print(data);
    Scaffold.of(context)
        .showBottomSheet<void>((BuildContext context) {
          final theme = Theme.of(context);
          return Card(
            margin: EdgeInsets.all(0.0),
            elevation: 30.0,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 48.0,
                left: 24.0,
                right: 24.0,
              ),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                        bottom: 16.0,
                      ),
                      child: Text(
                        "Applicant",
                        style: theme.textTheme.headline,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        bottom: 16.0,
                      ),
                      child: Text(
                        "Name: " + data.name,
                        style: theme.textTheme.body2,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        bottom: 16.0,
                      ),
                      child: Text(
                        "Email: " + data.email,
                        style: theme.textTheme.body2,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        bottom: 16.0,
                      ),
                      child: Text(
                        "Address: " + data.address,
                        style: theme.textTheme.body2,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        bottom: 16.0,
                      ),
                      child: Text(
                        "Mobile: " + data.mobile,
                        style: theme.textTheme.body2,
                      ),
                    ),
                    FutureBuilder(
                      future: getDoctors(HttpClient.of(context)),
                      builder: (BuildContext context,
                          AsyncSnapshot<Clients> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasError) {
                            return Text(snapshot.error.toString());
                          }
                          return DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              filled: true,
                              labelText: 'Doctor',
                            ),
                            items: snapshot.data.data.map((dynamic value) {
                              return DropdownMenuItem<String>(
                                value: value.uid,
                                child: new Text(value.name),
                              );
                            }).toList(),
                            value: clientUid,
                            onChanged: (data) {
                              setState(() {
                                print(data);
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
                    ButtonBar(
                      children: <Widget>[
                        RaisedButton(
                          child: Text("Ignore"),
                          onPressed: () async {
                            await HttpClient.of(context).client.post(
                                "/admin/update-user-approve-status",
                                body: {
                                  "id": id,
                                  "accept": true,
                                  "doctor": clientUid,
                                }).then((res) {
                              Navigator.of(context).pop();
                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Request rejected"),
                                ),
                              );
                              _reloadData();
                            }).catchError((res) {
                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Something went wrong"),
                                ),
                              );
                            });
                          },
                          color: Theme.of(context).errorColor,
                        ),
                        RaisedButton(
                          child: Text("Approve"),
                          onPressed: () async {
                            await HttpClient.of(context)
                                .client
                                .post(
                                  "/admin/update-user-approve-status",
                                  body: jsonEncode(
                                    {
                                      "id": id,
                                      "accept": true,
                                      "doctor": clientUid,
                                    },
                                  ),
                                )
                                .then((res) {
                              Navigator.of(context).pop();
                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Request accept"),
                                ),
                              );
                              _reloadData();
                            }).catchError((res) {
                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Something went wrong"),
                                ),
                              );
                            });
                          },
                          color: Theme.of(context).primaryColor,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        })
        .closed
        .whenComplete(() {
          if (mounted) {}
        });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PendingApproveUsers>(
      future: _pendingApprove,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            if (snapshot.data.data.length == 0) {
              return Center(
                child: Text("No pending approvals found"),
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.data.length,
              itemBuilder: (context, position) {
                return ListTile(
                  onTap: () {
                    _showBottomSheet(snapshot.data.data[position].value,
                        snapshot.data.data[position].id);
                  },
                  leading: CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  title: Text(snapshot.data.data[position].value.name),
                  subtitle: Text(
                    snapshot.data.data[position].value.email,
                  ),
                );
              },
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _reloadData();
  }
}
