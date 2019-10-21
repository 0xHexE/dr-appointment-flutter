import 'dart:async';

import 'package:appointment_app/auth/login.dart';
import 'package:appointment_app/pages/client_list.dart';
import 'package:appointment_app/pages/dashboard.dart';
import 'package:appointment_app/pages/doctor_list.dart';
import 'package:appointment_app/pages/my_account.dart';
import 'package:appointment_app/pages/notification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DrawerInternal extends StatelessWidget {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final userStatus;

  DrawerInternal({this.userStatus});

  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          AccountName(),
          ListTile(
            title: Text('Dashboard'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Dashboard(userStatus: userStatus,),
                ),
              );
            },
            leading: Icon(Icons.dashboard),
          ),
          ListTile(
            title: Text('Notifications'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotificationPage(),
                ),
              );
            },
            leading: Icon(Icons.notifications),
          ),
          userStatus.role == "doctor" ?
          ListTile(
            title: Text('Patients'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ClientList(),
                ),
              );
            },
            leading: Icon(Icons.group),
          ) : SizedBox.shrink(),
          userStatus.role == "doctor" ?
          ListTile(
            title: Text('Doctor'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DoctorList(),
                ),
              );
            },
            leading: Icon(Icons.local_hospital),
          ) : SizedBox.shrink(),
          ListTile(
            title: Text('My account'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyAccount()),
              );
            },
            leading: Icon(Icons.person),
          ),
          ListTile(
            title: Text('Logout'),
            onTap: () {
              _firebaseAuth.signOut().then((res) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Login(),
                  ),
                );
              });
            },
            leading: Icon(Icons.exit_to_app),
          ),
        ],
      ),
    );
  }
}

class AccountName extends StatefulWidget {
  @override
  _AccountNameState createState() => _AccountNameState();
}

class _AccountNameState extends State<AccountName> {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<FirebaseUser> _firebaseUser = FirebaseAuth.instance.currentUser();
  StreamSubscription _firebaseUserStram;

  @override
  void initState() {
    _firebaseUserStram = _firebaseAuth.onAuthStateChanged.listen((data) {
      this._firebaseUser = Future.value(data);
    });
    super.initState();
  }

  @override
  void dispose() {
    _firebaseUserStram.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _firebaseUser,
      builder: (BuildContext context,
          AsyncSnapshot<FirebaseUser> _firebaseUserInstance) {
        switch (_firebaseUserInstance.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            return Column();
          case ConnectionState.done:
            if (_firebaseUserInstance.hasData) {
              return UserAccountsDrawerHeader(
                accountName: Text(_firebaseUserInstance.data.displayName ?? ""),
                accountEmail: Text(_firebaseUserInstance.data.email),
                currentAccountPicture: CircleAvatar(
                  child: _firebaseUserInstance.data.photoUrl != null
                      ? Image.network(_firebaseUserInstance.data.photoUrl)
                      : Icon(Icons.person),
                ),
              );
            }
        }
        return Column();
      },
    );
  }
}
