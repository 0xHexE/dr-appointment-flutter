import 'package:appointment_app/auth/login.dart';
import 'package:appointment_app/pages/dashboard.dart';
import 'package:appointment_app/pages/registration/first_time_login.dart';
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
  Widget build(BuildContext buildContext) {
    return StreamBuilder<FirebaseUser>(
      stream: this._stream,
      builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
        HttpClient httpClient = HttpClient.of(context);

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
              return CheckIsFirstTimeLogin(
                dashboard: Dashboard(),
                firstTimeLogin: FirstTimeLoginPage(),
                firebaseAuth: firebaseAuth,
                httpClient: httpClient,
              );
            } else {
              return Login();
            }
        }
        return null;
      },
    );
  }
}

class CheckIsFirstTimeLogin extends StatelessWidget {
  CheckIsFirstTimeLogin({
    @required this.dashboard,
    @required this.firstTimeLogin,
    @required this.firebaseAuth,
    @required this.httpClient,
  }) {
    this.future = this.isHaveDatabase();
  }

  Future<dynamic> future;

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
              return Scaffold(
                body: Center(
                  child: Text("Waiting for confirmation"),
                ),
              );
            case "done":
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
