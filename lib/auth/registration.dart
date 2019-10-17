import 'package:appointment_app/pages/registration/first_time_login.dart';
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

  bool isLoading = false;

  void onAuthSuccess(AuthResult authResult) {
    isLoading = false;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => FirstTimeLoginPage()),
    );
  }

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
            Padding(
              padding: const EdgeInsets.only(top: 56.0),
              child: Text(
                'Create your account to get started',
                style: Theme.of(context).textTheme.headline,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: TextFormField(
                validator: isEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Email address",
                ),
                controller: _emailController,
              ),
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
                  child: Text(isLoading ? "Creating account.." : "Sign up"),
                  onPressed: () {
                    if (isLoading) {
                      return;
                    }
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
          ].map((res) {
            return Padding(
              child: res,
              padding: EdgeInsets.only(
                bottom: 16.0,
                right: 22.0,
                left: 22.0,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
