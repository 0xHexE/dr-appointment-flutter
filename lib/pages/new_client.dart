import 'dart:convert';

import 'package:appointment_app/pages/client_info.dart';
import 'package:appointment_app/utils/http_client.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewClient extends StatefulWidget {
  @override
  _NewClientState createState() => _NewClientState();
}

class _NewClientState extends State<NewClient> {
  final format = DateFormat("dd-MM-yyyy");
  final _form = GlobalKey<FormState>();
  final _scaffold = GlobalKey<ScaffoldState>();

  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _dateOfBirthController = TextEditingController();

  var isLoading = false;

  void handleSave(BuildContext context) async {
    final data = _scaffold.currentState.showSnackBar(SnackBar(
      content: Text('Creating...'),
    ));

    final response = await HttpClient.of(context).client.post("/clients/create",
        body: json.encode({
          "name": _nameController.text,
          "address": _addressController.text,
          "email": _emailController.text,
          "phoneNumber": _emailController.text,
          "dateOfBirth": _dateOfBirthController.text,
        }));

    data.close();

    final decodedBody = json.decode(response.body);

    if (response.statusCode != 201) {
      _scaffold.currentState.showSnackBar(SnackBar(
        content: Text(decodedBody['error']),
      ));
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => ClientInfo(
          clientId: decodedBody['id'],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _dateOfBirthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
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
      body: Form(
        key: _form,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Name',
                hintText: 'Name',
              ),
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
              minLines: 3,
              enabled: !isLoading,
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Email',
                hintText: 'Email',
              ),
              keyboardType: TextInputType.emailAddress,
              enabled: !isLoading,
            ),
            TextFormField(
              controller: _phoneNumberController,
              decoration: InputDecoration(
                  filled: true,
                  labelText: 'Phone number',
                  hintText: 'Phone number'),
              keyboardType: TextInputType.phone,
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
        child: Icon(Icons.save),
      ),
    );
  }
}
