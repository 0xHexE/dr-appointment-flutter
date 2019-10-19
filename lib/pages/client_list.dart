import 'package:after_layout/after_layout.dart';
import 'package:appointment_app/components/pending_clients_list.dart';
import 'package:appointment_app/model/client_list_model.dart';
import 'package:appointment_app/pages/client_info.dart';
import 'package:appointment_app/services/client_list_service.dart';
import 'package:appointment_app/utils/http_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'create_user.dart';

class ClientList extends StatefulWidget {
  @override
  _ClientListState createState() => _ClientListState();
}

class _ClientListState extends State<ClientList>
    with AfterLayoutMixin<ClientList> {
  Future<Clients> _clients;

  void getClientsFuture() {
    setState(() {
      _clients = getClients(
        HttpClient.of(context),
      );
    });
  }

  void _reloadData() {
    this.getClientsFuture();
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                text: "All",
              ),
              Tab(
                text: "Pending for approval",
              ),
            ],
          ),
          title: Text("Pentients"),
        ),
        body: TabBarView(
          children: [
            FutureBuilder<Clients>(
              future: _clients,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Something went wrong"),
                    );
                  }

                  if (snapshot.data.data.length == 0) {
                    return Center(
                      child: Text("No patients found"),
                    );
                  }

                  return ListView.builder(
                    itemCount: snapshot.data.data.length,
                    itemBuilder: (context, position) {
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ClientInfo(
                                clientId: snapshot.data.data[position].uid,
                              ),
                            ),
                          );
                        },
                        leading: CircleAvatar(
                          child: Icon(Icons.person),
                        ),
                        title: Text(snapshot.data.data[position].name),
                        subtitle: Text(
                          snapshot.data.data[position].email ?? '',
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            PendingClientsList(),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateUserPage(
                  type: 'client',
                ),
              ),
            );
          },
          icon: Icon(Icons.add),
          label: Text("New client"),
        ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    print("Loading");
    _reloadData();
  }
}
