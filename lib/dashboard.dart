// import 'package:appointment_app/calendar.dart';
import 'package:flutter_app/calender.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/services/dashboard_service.dart';

import 'components/drawer.dart';
import 'components/menu_toggle_button.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          FutureBuilder(
            future: getDashboardData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Text('error');
                }
                return Text(snapshot.data.toString());
              }else {
                return CircularProgressIndicator();
              }
            },
          )
        ],
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {

        },
      ),
      drawer: DrawerInternal(),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 4.0,
        child: new Row(
          children: <Widget>[
            MenuToggleButton(),
            IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Calendar()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
