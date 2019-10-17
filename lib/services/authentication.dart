import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Future<String> signIn(String email, String password);

  Future<String> signUp(String email, String password);

  Future<FirebaseUser> getCurrentUser();

  Future<void> sendEmailVerification();

  Future<void> signOut();

  Future<bool> isEmailVerified();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> signIn(String email, String password) async {
    AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    return user.uid;
  }

  Future<String> signUp(String email, String password) async {
    AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    return user.uid;
  }

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }
}

class UserStatus {
  Data data;

  UserStatus({
    this.data,
  });

  factory UserStatus.fromJson(String str) =>
      UserStatus.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserStatus.fromMap(Map<String, dynamic> json) => UserStatus(
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data == null ? null : data.toMap(),
      };
}

class Data {
  String status;
  String userId;
  String role;

  Data({
    this.status,
    this.userId,
    this.role,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        status: json["status"] == null ? null : json["status"],
        userId: json["userId"] == null ? null : json["userId"],
        role: json["role"] == null ? null : json["role"],
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? null : status,
        "userId": userId == null ? null : userId,
        "role": role == null ? null : role,
      };
}
