import 'package:appointment_app/root.dart';
import 'package:flutter/material.dart';

// void main() => runApp(MyApp());
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Appointment Application',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: Root(),
      routes: <String, WidgetBuilder>{
//        'showHomePage': (BuildContext context) => MyHomePage(title: 'test'),
      },
    );
  }
}
