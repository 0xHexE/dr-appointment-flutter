import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/services/client_add_service.dart';
import 'package:intl/intl.dart';

class NewClient extends StatefulWidget {
  @override
  _NewClientState createState() => _NewClientState();
}

class _NewClientState extends State<NewClient> {
  final format = DateFormat("yyyy-MM-dd HH:mm");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your client',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              filled: true,
              labelText: 'Name',
            ),
          ),
          TextField(
            decoration: InputDecoration(
              filled: true,
              labelText: 'Address',
            ),
            maxLines: 3,
            minLines: 3,
          ),
          DateTimeField(
            decoration: InputDecoration(
              filled: true,
              labelText: 'Date of birth',
            ),
            format: format,
            onShowPicker: (context, currentValue) {
              return showDatePicker(
                context: context,
                firstDate: DateTime(1900),
                initialDate: currentValue ?? DateTime.now(),
                lastDate: DateTime(2100),
              );
            },
          ),
        ].map((res) {
          return Padding(
            child: res,
            padding: EdgeInsets.fromLTRB(0, 6.0, 0.0, 6.0),
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () { var res = addClient('test', 'test', 'test'); },
        isExtended: true,
        child: Icon(Icons.save),
      ),
    );
  }
}
