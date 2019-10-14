import 'dart:math';

// import 'package:appointment_app/components/drawer.dart';
import 'package:appointment_app/components/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:appointment_app/services/calender_service.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/standalone.dart';

import 'components/calendar/calendar.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  List<CalendarEvent> events = <CalendarEvent>[];
  Location loc;
  Random random = new Random();

  Widget buildItem(BuildContext context, CalendarEvent e) {
    return new Card(
      child: new ListTile(
        title: new Text("Event ${e.index}"),
        subtitle: new Text("Yay for events"),
        leading: const Icon(Icons.gamepad),
      ),
    );
  }

  List<CalendarEvent> getEvents(DateTime start, DateTime end) {
    List<CalendarEvent> events = <CalendarEvent>[];
    Location loc;
    Random random = new Random();

    if (loc != null && events.length == 0) {
      TZDateTime nowTime =
      new TZDateTime.now(loc).subtract(new Duration(days: 5));
      for (int i = 0; i < 20; i++) {
        TZDateTime start =
        nowTime.add(new Duration(days: i + random.nextInt(10)));
        events.add(new CalendarEvent(
            index: i,
            instant: start,
            instantEnd: start.add(new Duration(minutes: 30))));
      }
    }
    return events;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: ToggleMenu(),
        title: Column(
          children: <Widget>[Text('Omkar')],
        ),
      ),
      body: new Column(
        children: <Widget>[
          new FutureBuilder<String>(
            future: FlutterNativeTimezone.getLocalTimezone(),
            builder: (BuildContext context, AsyncSnapshot<String> tz) {
              if (tz.hasError) {
                print(tz.error);
                return Text(tz.error);
              }
              if (tz.hasData) {
                loc = getLocation(tz.data);
                TZDateTime nowTime = new TZDateTime.now(loc);
                return new Expanded(
                  child: new CalendarWidget(
                    initialDate: nowTime,
                    beginningRangeDate:
                    nowTime.subtract(new Duration(days: 31)),
                    endingRangeDate: nowTime.add(new Duration(days: 31)),
                    location: loc,
                    buildItem: buildItem,
                    getEvents: getEvents,
                    bannerHeader:
                    new AssetImage("assets/images/calendarheader.png"),
                    monthHeader:
                    new AssetImage("assets/images/calendarbanner.jpg"),
                    weekBeginsWithDay:
                    1, // Sunday = 0, Monday = 1, Tuesday = 2, ..., Saturday = 6
                  ),
                );
              } else {
                return new Center(
                  child: new Text("Getting the timezone..."),
                );
              }
            },
          ),
          FutureBuilder(
            future: getTodaySchedule(),
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
      drawer: DrawerInternal(),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 4.0,
        icon: const Icon(Icons.add),
        label: const Text('New appointment'),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class ToggleMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: Colors.black,
      icon: Icon(Icons.menu),
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
    );
  }
}
