import 'package:appointment_app/utils/is-email.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController(),
      _passwordController = TextEditingController();

  void onAuthSuccess(AuthResult authResult) {}

  void onAuthFailure(PlatformException exception) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(exception.message),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            TextFormField(
              validator: isEmail,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "Email address",
              ),
              controller: _emailController,
            ),
            TextFormField(
              validator: minWidth,
              decoration: InputDecoration(
                hintText: "Password",
              ),
              obscureText: true,
              controller: _passwordController,
            ),
            ButtonBar(
              children: <Widget>[
                RaisedButton(
                  child: Text("Sign up"),
                  onPressed: () {
                    _firebaseAuth
                        .createUserWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text,
                        )
                        .then(this.onAuthSuccess)
                        .catchError(
                          (exception) => this.onAuthFailure(exception),
                        );
                  },
                )
              ],
              alignment: MainAxisAlignment.end,
            ),
          ],
        ),
      ),
    );
  }
}
