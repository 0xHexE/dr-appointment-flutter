import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timezone/timezone.dart';

import 'app_config.dart';
import 'dashboard.dart';

/// The main gallery app widget.
class GalleryApp extends StatefulWidget {
  GalleryApp({Key key}) : super(key: key);

  @override
  GalleryAppState createState() => new GalleryAppState();
}

/// The main gallery app state.
///
/// Controls performance overlay, and instantiates a [Home] widget.
class GalleryAppState extends State<GalleryApp> {
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
    rootBundle.load('assets/timezone/2018c.tzf').then((ByteData data) {
      loadedData = data;
      print('loaded data');
    })
  ]);
  initializeDatabase(loadedData.buffer.asUint8List());

  runApp(new GalleryApp());
}
