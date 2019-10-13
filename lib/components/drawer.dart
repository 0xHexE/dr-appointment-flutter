// import 'package:appointment_app/client_list.dart';
import 'package:appointment_app/pages/client_list.dart';
import 'package:appointment_app/pages/my_account.dart';
import 'package:appointment_app/pages/notification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DrawerInternal extends StatelessWidget {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('hello'),
            accountEmail: Text('hello@hello.hello'),
            currentAccountPicture: CircleAvatar(
              child: Icon(Icons.person),
            ),
          ),
          ListTile(
            title: Text('Dashboard'),
            onTap: () {
              Navigator.pop(context);
            },
            leading: Icon(Icons.dashboard),
          ),
          ListTile(
            title: Text('Notifications'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NotificationPage()));
            },
            leading: Icon(Icons.notifications),
          ),
          ListTile(
            title: Text('Patients'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ClientList()),
              );
            },
            leading: Icon(Icons.group),
          ),
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
              _firebaseAuth.signOut();
            },
            leading: Icon(Icons.exit_to_app),
          ),
        ],
      ),
    );
  }
}
