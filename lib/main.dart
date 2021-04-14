import 'package:flutter/material.dart';
import 'package:steps_tracker/app/locator/locator.dart';
import 'package:steps_tracker/app/steps_tracker_app.dart';

void main() {
  /// make sure the glue that binds the framework to the Flutter engine
  /// is initialized.
  WidgetsFlutterBinding.ensureInitialized();

  /// initialize locator (dependency injector)
  configureDependencies();

  /// Runs the app :)
  runApp(StepsTrackerApp());
}
