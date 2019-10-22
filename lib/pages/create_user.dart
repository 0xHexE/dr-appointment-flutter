import 'dart:convert';

import 'package:after_layout/after_layout.dart';
import 'package:appointment_app/model/client_list_model.dart';
import 'package:appointment_app/services/client_list_service.dart';
import 'package:appointment_app/utils/http_client.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateUserPage extends StatefulWidget {
  CreateUserPage({@required this.type});

  String type;

  @override
  _CreateUserPageState createState() => _CreateUserPageState(type: type);
}

class _CreateUserPageState extends State<CreateUserPage> with AfterLayoutMixin {
  _CreateUserPageState({@required this.type}) {}

  final String type;
  final format = DateFormat("dd-MM-yyyy");
  final _form = GlobalKey<FormState>();
  final _scaffold = GlobalKey<ScaffoldState>();

  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _dateOfBirthController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  final _emailController = TextEditingController();

  var isLoading = false;

  Future<Clients> _doctorListFuture;

  void loadDoctors() {
    setState(() {
      this._doctorListFuture = getDoctors(HttpClient.of(context));
    });
  }

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

    Map<String, dynamic> form = {
      "name": _nameController.text,
      "address": _addressController.text,
      "mobile": _mobileNumberController.text,
      "email": _emailController.text,
      "type": type
    };

    if (type == "client") {
      final date = _dateOfBirthController.text;
      final dateArray = date.split("-");
      final dateOfBirth = DateTime.utc(int.parse(dateArray[2]),
          int.parse(dateArray[1]), int.parse(dateArray[0]));
      form["dateOfBirth"] = dateOfBirth.millisecondsSinceEpoch;
    }

    if (clientUid != null) {
      form["doctor"] = clientUid;
    }

    HttpClient.of(context)
        .client
        .post(
          "/admin/add-user",
          body: json.encode(form),
        )
        .then((res) {
      data.close();
      final decodedBody = json.decode(res.body);
      Navigator.of(context).pop();
    }).catchError((dynamic err) {
      try {
        data.close();
      } catch (e) {}
      isLoading = false;
      _scaffold.currentState.showSnackBar(SnackBar(
        content: Text(err.body.toString()),
      ));
    });
  }

  String clientUid;

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _dateOfBirthController.dispose();
    _mobileNumberController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      appBar: AppBar(
        title: Text("Your user"),
      ),
      body: Form(
        key: _form,
        child: ListView(
          padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 36.0),
          children: <Widget>[
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
              controller: _mobileNumberController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Mobile',
                hintText: 'Mobile',
              ),
              validator: (res) {
                if (res.trim() == "") {
                  return "Mobile is required";
                } else if (res.trim().length != 10) {
                  return "Invalid mobile";
                } else {
                  return null;
                }
              },
              enabled: !isLoading,
            ),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Email',
                hintText: 'Email',
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
            type == 'client'
                ? DateTimeField(
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
                  )
                : Container(),
            type != 'client'
                ? Container()
                : FutureBuilder(
                    future: _doctorListFuture,
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

  @override
  void afterFirstLayout(BuildContext context) {
    loadDoctors();
  }
}
