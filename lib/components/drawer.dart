// import 'package:appointment_app/client_list.dart';
import 'package:appointment_app/client_list.dart';
import 'package:appointment_app/my_account.dart';
import 'package:appointment_app/notification.dart';
import 'package:flutter/material.dart';

class DrawerInternal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Row(
              children: <Widget>[
                Icon(Icons.person),
              ],
            ),
            decoration: BoxDecoration(),
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
              Navigator.pop(context);
            },
            leading: Icon(Icons.exit_to_app),
          ),
        ],
      ),
    );
  }
}
