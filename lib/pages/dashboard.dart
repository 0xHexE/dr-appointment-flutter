// import 'package:appointment_app/calendar.dart';
import 'package:appointment_app/components/dashboard/chart.dart';
import 'package:appointment_app/components/dashboard/next_appoitment.dart';
import 'package:appointment_app/model/dashboard_model.dart';
import 'package:appointment_app/pages/calender.dart';
import 'package:appointment_app/pages/client_list.dart';
import 'package:appointment_app/pages/new_appointment.dart';
import 'package:appointment_app/pages/new_calender.dart';
import 'package:appointment_app/services/dashboard_service.dart';
import 'package:flutter/material.dart';

import '../components/drawer.dart';
import '../components/menu_toggle_button.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder<DashboardData>(
          future: getDashboardData(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }

              final data = snapshot.data.data.map((res) {
                switch (res.chartType) {
                  case "gauge":
                    return SizedBox(
                        height: 340.0,
                        child: GaugeChart(
                          GaugeChart.fromDashboardData(res.data),
                          animate: true,
                        ));
                  default:
                    return Text("Chart is not supported");
                }
              }).map((res) {
                return Padding(
                  child: res,
                  padding: EdgeInsets.all(8.0),
                );
              });
              return ListView(
                children: [
                  ...data,
                  Text(
                    "Total appointments of today",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.caption,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 12.0,
                      bottom: 12.0,
                    ),
                    child: Text(
                      "Next appointment in 30 mins",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.body2.copyWith(),
                    ),
                  ),
                  Divider(),
                  NextAppointmentData(),
                ],
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewAppointment()),
          );
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
                  MaterialPageRoute(builder: (context) => NewCalendar()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ClientList()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
