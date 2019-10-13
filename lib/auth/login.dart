import 'package:appointment_app/auth/registration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'forget_password.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _InternalLoginForm(),
    );
  }
}

class _InternalLoginForm extends StatefulWidget {
  @override
  _InternalLoginFormState createState() => _InternalLoginFormState();
}

class _InternalLoginFormState extends State<_InternalLoginForm> {
  @override
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController(),
      _passwordController = TextEditingController();

  void _callbackSuccessLogin(AuthResult authResult) {
    // Blank due to the stream
  }

  void _callbackFailLogin(PlatformException error, BuildContext context) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(error.message),
      ),
    );
  }

  void openRegistration() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Registration()),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Text(
          "Sign in",
        ),
        Text("Use your account"),
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            filled: true,
            hintText: "Email",
          ),
        ),
        TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(filled: true, hintText: "Password"),
        ),
        ButtonBar(
          children: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ForgetPassword(),
                  ),
                );
              },
              child: Text("Forget password?"),
            ),
            RaisedButton(
              child: Text("Login"),
              onPressed: () {
                _firebaseAuth
                    .signInWithEmailAndPassword(
                      email: _emailController.text,
                      password: _passwordController.text,
                    )
                    .then(
                      (authResult) => this._callbackSuccessLogin(authResult),
                    )
                    .catchError(
                      (data) => this._callbackFailLogin(data, context),
                    );
              },
            )
          ],
          alignment: MainAxisAlignment.end,
        ),
        ButtonBar(
          alignment: MainAxisAlignment.end,
          children: <Widget>[
            RaisedButton(
              child: Text("Sign up?"),
              onPressed: this.openRegistration,
            ),
          ],
        )
      ],
    );
  }
}
