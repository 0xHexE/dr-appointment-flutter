import 'dart:async';

import 'package:appointment_app/auth/login.dart';
import 'package:appointment_app/pages/dashboard.dart';
import 'package:appointment_app/pages/registration/first_time_login.dart';
import 'package:appointment_app/pages/registration/waiting-for-confirm.dart';
import 'package:appointment_app/services/authentication.dart';
import 'package:appointment_app/utils/http_client.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  Stream<FirebaseUser> _stream = FirebaseAuth.instance.onAuthStateChanged;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.onAuthStateChanged.first.then((res) async {
      if (res == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      } else {
        HttpClient httpClient = HttpClient.of(context);
        try {
          final snapshot = await httpClient.client.get("/onboard/status");
          final userStatus = UserStatus.fromJson(snapshot.body);
          Widget widget;
          switch (userStatus.data.status) {
            case "not-registered":
              widget = FirstTimeLoginPage();
              break;
            case "pending":
              widget = WaitingForConfirm();
              break;
            case "approved":
              widget = Dashboard();
              break;
          }
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => widget),
          );
        } catch (e) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Scaffold(
                body: Text(
                  "Error" + e.toString(),
                ),
              ),
            ),
          );
        }
      }
    });
  }

  Widget loadingScreen() {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class CheckIsFirstTimeLogin extends StatelessWidget {
  CheckIsFirstTimeLogin({
    @required this.dashboard,
    @required this.firstTimeLogin,
    @required this.firebaseAuth,
    @required this.httpClient,
    @required BuildContext context,
  }) {
    this.future = this.isHaveDatabase();
  }

  Future<Response> future;

  final Widget dashboard, firstTimeLogin;
  final FirebaseAuth firebaseAuth;
  final HttpClient httpClient;

  Future<Response> isHaveDatabase() {
    return this.httpClient.client.get("/onboard/status");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Response>(
      future: future,
      builder: (BuildContext context, AsyncSnapshot<Response> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text("Test"),
              ),
            );
          }
          final userStatus = UserStatus.fromJson(snapshot.data.body);
          switch (userStatus.data.status) {
            case "not-registered":
              return FirstTimeLoginPage();
            case "pending":
              return WaitingForConfirm();
            case "approved":
              return Dashboard();
          }
          return null;
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
