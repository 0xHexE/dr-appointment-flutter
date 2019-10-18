import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

final String apiEndpoint = "http://10.0.2.2:3000/data/api/v1";

class HttpClient extends InheritedWidget {
  HttpClient({Key key, Widget child, this.firebaseAuth})
      : super(key: key, child: child) {
    client = HttpClientWithInterceptor.build(
      interceptors: [
        LoginInterceptor(firebaseAuth: firebaseAuth),
      ],
    );
  }

  Client client;
  FirebaseAuth firebaseAuth;
  String currentToken;

  String getCurrentToken() {
    return this.currentToken;
  }

  @override
  InheritedElement createElement() {
    return super.createElement();
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static HttpClient of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(HttpClient);
}

class LoginInterceptor implements InterceptorContract {
  final FirebaseAuth firebaseAuth;
  StreamSubscription _streamSubscription;

  LoginInterceptor({this.firebaseAuth}) {
    this._streamSubscription =
        this.firebaseAuth.onAuthStateChanged.listen((onData) {
      if (onData != null) {
        onData.getIdToken().then((onValue) {
          this.currentToken = onValue.token;
          print(this.currentToken);
        });
      } else {
        this.currentToken = null;
      }
    });
  }

  void dispose() {
    this._streamSubscription.cancel();
  }

  String currentToken;

  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    data.url = '$apiEndpoint${data.url}';
    final fireAuth = await this.firebaseAuth.currentUser().catchError((e) {
      return null;
    });

    print(data.body);

    if (currentToken == null) {
      currentToken = (await fireAuth.getIdToken()).token;
    }

    if (currentToken != null) {
      data.headers['Authorization'] = 'Bearer $currentToken';
    }
    data.headers['Content-Type'] = 'application/json';

    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    if (data.statusCode < 200 || data.statusCode > 299) {
      print(data.body);
      throw data;
    }
    return data;
  }
}
