import 'dart:math';

import 'package:appointment_app/components/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timezone/standalone.dart';

import 'components/calendar/calendar.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
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
      body: CalendarWidget(
        getEvents: getEvents,
        buildItem: buildItem,
        initialDate: TZDateTime.now(getLocation('America/Detroit')),
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
