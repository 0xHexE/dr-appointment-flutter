import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    this._emailController.dispose();
    super.dispose();
  }

  void onEmailSend(dynamic _value) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text("Email send successfully"),
      ),
    );
  }

  void onEmailSendFail(PlatformException exception) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(exception.message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: ListView(
        children: <Widget>[
          TextField(
            controller: _emailController,
            decoration: InputDecoration(hintText: "Email"),
          ),
          ButtonBar(
            children: <Widget>[
              FlatButton(
                child: Text("Back to login"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              RaisedButton(
                onPressed: () {
                  _firebaseAuth
                      .sendPasswordResetEmail(email: _emailController.text)
                      .then(this.onEmailSend)
                      .catchError((err) => this.onEmailSendFail(err));
                },
                child: Text("Send reset login email"),
              )
            ],
          )
        ],
      ),
    );
  }
}
