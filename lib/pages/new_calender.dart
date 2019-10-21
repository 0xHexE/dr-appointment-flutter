import 'package:appointment_app/components/dashboard/next_appoitment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewCalendar extends StatefulWidget {
  @override
  _NewCalendarState createState() => _NewCalendarState();
}

class _NewCalendarState extends State<NewCalendar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  DateTime selectedData = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointments'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () async {
              final date = await showDatePicker(
                context: context,
                firstDate: DateTime(1900),
                initialDate: DateTime.now(),
                lastDate: DateTime(2100),
              );

              setState(() {
                selectedData = date;
              });
            },
          )
        ],
      ),
      body: AppointmentsViewer(
        toDate: DateTime(
          selectedData.year,
          selectedData.month,
          selectedData.day,
          23,
          59,
        ).millisecondsSinceEpoch,
        fromDate: DateTime(
          selectedData.year,
          selectedData.month,
          selectedData.day,
        ).millisecondsSinceEpoch,
      ),
    );
  }
}
