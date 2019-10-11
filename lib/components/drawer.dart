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
              Navigator.pop(context);
            },
            leading: Icon(Icons.notifications),
          ),
          ListTile(
            title: Text('Patients'),
            onTap: () {
              Navigator.pop(context);
            },
            leading: Icon(Icons.group),
          ),
          ListTile(
            title: Text('My account'),
            onTap: () {
              Navigator.pop(context);
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
