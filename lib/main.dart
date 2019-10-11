import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timezone/timezone.dart';

import 'app_config.dart';
import 'dashboard.dart';

/// The main gallery app widget.
class MainApp extends StatefulWidget {
  MainApp({Key key}) : super(key: key);

  @override
  MainAppState createState() => new MainAppState();
}

/// The main gallery app state.
///
/// Controls performance overlay, and instantiates a [Home] widget.
class MainAppState extends State<MainApp> {
  // Initialize app settings from the default configuration.
  bool _showPerformanceOverlay = defaultConfig.showPerformanceOverlay;

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: defaultConfig.appName,
      theme: defaultConfig.theme,
      showPerformanceOverlay: _showPerformanceOverlay,
      home: new Dashboard(),
    );
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
