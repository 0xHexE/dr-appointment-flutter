import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

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
    if (currentToken == null) {
      data.headers['Authorization'] = 'Bearer $currentToken';
    }

    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    return data;
  }
}
