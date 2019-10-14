import 'package:appointment_app/root.dart';
import 'package:appointment_app/utils/http_client.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timezone/timezone.dart';

import 'app_config.dart';

/// The main gallery app widget.
class MainApp extends StatefulWidget {
  MainApp({Key key}) : super(key: key);

  @override
  _MainAppState createState() => new _MainAppState();
}

/// The main gallery app state.
///
/// Controls performance overlay, and instantiates a [Home] widget.
class _MainAppState extends State<MainApp> {
  // Initialize app settings from the default configuration.
  bool _showPerformanceOverlay = defaultConfig.showPerformanceOverlay;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return HttpClient(
        firebaseAuth: _firebaseAuth,
        child: MaterialApp(
          title: defaultConfig.appName,
          theme: defaultConfig.theme,
          showPerformanceOverlay: _showPerformanceOverlay,
          home: Root(),
        ));
  }
}

void main() async {
  ByteData loadedData;

  await Future.wait<void>(<Future<void>>[
    rootBundle.load('assets/2019b.tzf').then((ByteData data) {
      loadedData = data;
      print('loaded data');
    })
  ]);

  initializeDatabase(loadedData.buffer.asUint8List());

  runApp(new MainApp());
}
