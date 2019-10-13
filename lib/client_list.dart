// import 'package:appointment_app/new_client.dart';
import 'package:appointment_app/new_client.dart';
import 'package:appointment_app/services/client_list_service.dart';
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
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          FutureBuilder(
              future: getClients(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Text('error');
                  }
                  return Text(snapshot.data.toString());
                } else {
                  return CircularProgressIndicator();
                }
              })
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewClient()),
          );
        },
        icon: Icon(Icons.add),
        label: Text("New client"),
      ),
    );
  }
}
