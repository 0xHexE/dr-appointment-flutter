import 'package:flutter/material.dart';

/// A particular configuration of the app.
class AppConfig {
  final String appName;
  final String appLink;
  final ThemeData theme;
  final bool showPerformanceOverlay;

  AppConfig(
      {this.appName, this.appLink, this.theme, this.showPerformanceOverlay});
}

/// The default configuration of the app.
AppConfig get defaultConfig {
  return new AppConfig(
    appName: 'Charts Gallery',
    appLink: '',
    theme: new ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.deepPurple,
    ),
    showPerformanceOverlay: false,
  );
}
