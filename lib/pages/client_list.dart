import 'package:appointment_app/model/client_list_model.dart';
import 'package:appointment_app/pages/create_user.dart';
import 'package:appointment_app/services/client_list_service.dart';
import 'package:appointment_app/utils/http_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClientList extends StatefulWidget {
  @override
  _ClientListState createState() => _ClientListState();
}

class _ClientListState extends State<ClientList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Clients"),
      ),
      body: FutureBuilder<Clients>(
        future: getClients(
          HttpClient.of(context),
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }

            if (snapshot.data.data.length == 0) {
              return Center(
                child: Text("No clients found"),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data.data.length,
              itemBuilder: (context, position) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      position.toString(),
                      style: TextStyle(fontSize: 22.0),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
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
    );
  }
}
