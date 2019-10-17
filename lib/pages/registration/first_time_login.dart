import 'dart:convert';

import 'package:appointment_app/pages/client_info.dart';
import 'package:appointment_app/utils/http_client.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FirstTimeLoginPage extends StatefulWidget {
  @override
  _FirstTimeLoginPageState createState() => _FirstTimeLoginPageState();
}

class _FirstTimeLoginPageState extends State<FirstTimeLoginPage> {
  final format = DateFormat("dd-MM-yyyy");
  final _form = GlobalKey<FormState>();
  final _scaffold = GlobalKey<ScaffoldState>();

  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _dateOfBirthController = TextEditingController();
  final _descriptionController = TextEditingController();

  var isLoading = false;

  void handleSave(BuildContext context) async {
    if (!_form.currentState.validate()) {
      final data = _scaffold.currentState.showSnackBar(SnackBar(
        content: Text('Please enter the form values'),
      ));
      return;
    }

    final data = _scaffold.currentState.showSnackBar(SnackBar(
      content: Text('Creating...'),
    ));
    isLoading = true;

    print(json.encode(
      {
        "name": _nameController.text,
        "address": _addressController.text,
        "dateOfBirth": _dateOfBirthController.text,
        "description": _descriptionController.text,
      },
    ));
    HttpClient.of(context)
        .client
        .post(
          "/onboard/start",
          body: json.encode(
            {
              "name": _nameController.text,
              "address": _addressController.text,
              "dateOfBirth": _dateOfBirthController.text,
              "description": _descriptionController.text,
            },
          ),
        )
        .then((res) {
      data.close();
      final decodedBody = json.decode(res.body);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => ClientInfo(
            clientId: decodedBody['id'],
          ),
        ),
      );
    }).catchError((dynamic err) {
      data.close();
      final snackError = _scaffold.currentState.showSnackBar(SnackBar(
        content: Text(err.body.toString()),
      ));
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _dateOfBirthController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      body: Form(
        key: _form,
        child: ListView(
          padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 36.0),
          children: <Widget>[
            Text(
              "Fill out your information",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.title,
            ),
            Text(
              "to continue with us",
              textAlign: TextAlign.center,
            ),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Name',
                hintText: 'Name',
              ),
              validator: (res) {
                if (res.trim() == "") {
                  return "Name is required";
                } else {
                  return null;
                }
              },
              enabled: !isLoading,
            ),
            TextFormField(
              controller: _addressController,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Address',
                hintText: 'Address',
              ),
              maxLines: 3,
              validator: (res) {
                if (res.trim() == "") {
                  return "Address is required";
                } else {
                  return null;
                }
              },
              minLines: 3,
              enabled: !isLoading,
            ),
            DateTimeField(
              controller: _dateOfBirthController,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Date of birth',
                hintText: 'Date of birth',
              ),
              format: format,
              validator: (res) {
                if (res == null || res.isAfter(DateTime.now())) {
                  return "Enter valid date of bith";
                } else {
                  return null;
                }
              },
              enabled: !isLoading,
              onShowPicker: (context, currentValue) {
                return showDatePicker(
                  context: context,
                  firstDate: DateTime(1900),
                  initialDate: currentValue ?? DateTime.now(),
                  lastDate: DateTime(2100),
                );
              },
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Description',
                hintText: 'Description',
              ),
              maxLines: 3,
              minLines: 3,
              validator: (res) {
                if (res.trim() == "") {
                  return "Description is required";
                } else {
                  return null;
                }
              },
              enabled: !isLoading,
            ),
          ].map((res) {
            return Padding(
              child: res,
              padding: EdgeInsets.fromLTRB(0, 6.0, 0.0, 6.0),
            );
          }).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => handleSave(context),
        isExtended: true,
        child: Icon(Icons.navigate_next),
      ),
    );
  }
}
