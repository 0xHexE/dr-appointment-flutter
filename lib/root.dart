import 'package:appointment_app/auth/login.dart';
import 'package:appointment_app/pages/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Stream<FirebaseUser> _stream = FirebaseAuth.instance.onAuthStateChanged;

  @override
  void initState() {
    super.initState();
  }

  Widget loadingScreen() {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
      stream: this._stream,
      builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        print(snapshot.data);
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return loadingScreen();
          case ConnectionState.none:
            return Login();
            break;
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasData) {
              return Dashboard();
            } else {
              return Login();
            }
        }

        return null;
      },
    );
  }
}
