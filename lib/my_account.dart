import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:appointment_app/model/my_account_model.dart';
import 'package:appointment_app/services/my_account_service.dart';

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Acoount'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ),
      body: FutureBuilder<MyAccountModel> (
        future: getAccountInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text('error');
            }
            return Text(snapshot.data.toString());
          }else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
