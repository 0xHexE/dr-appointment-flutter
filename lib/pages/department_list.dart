
import 'package:appointment_app/services/department_list_service.dart';
import 'package:appointment_app/utils/http_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DepartmentList extends StatefulWidget {
  @override
  _DepartmentListState createState() => _DepartmentListState();
}

var test  = [ {'name': 'test'}, {'name': 'test'}, {'name': 'test'}, {'name': 'test'}, {'name': 'test'}, {'name': 'test'} ];

class _DepartmentListState extends State<DepartmentList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Department List'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: FutureBuilder(
        future: getDepartmentList(HttpClient.of(context)),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return AlertDialog(
              title: Text('Network Error'),
              content: Text('Check your Internet Connection'),
            );
          }

          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data.data.length,
            itemBuilder: (context, index) {

              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(snapshot.data.data[index].name[0].toString().toUpperCase()),
                  ),
                  title: Text(snapshot.data.data[index].name),
                ),
              );
            },
          );
        },
      )
    );
  }
}