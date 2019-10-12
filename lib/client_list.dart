import 'package:appointment_app/new_client.dart';
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
