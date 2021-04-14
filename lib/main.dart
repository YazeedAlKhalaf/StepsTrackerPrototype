import 'package:flutter/material.dart';

import 'package:steps_tracker/app/locator/locator.dart';
import 'package:steps_tracker/app/services/firebase_service.dart';
import 'package:steps_tracker/app/steps_tracker_app.dart';

Future<void> main() async {
  /// general todos
  // TODO: add iOS config firebase

  /// make sure the glue that binds the framework to the Flutter engine
  /// is initialized.
  WidgetsFlutterBinding.ensureInitialized();

  /// initialize locator (dependency injector)
  configureDependencies();

  /// initialize firebase
  await locator<FirebaseService>().init();

  /// Runs the app :)
  runApp(StepsTrackerApp());
}
