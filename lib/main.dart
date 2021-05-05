import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:steps_tracker/app/locator/locator.dart';
import 'package:steps_tracker/app/services/firebase_service.dart';
import 'package:steps_tracker/app/steps_tracker_app.dart';
import 'package:theme_mode_builder/theme_mode_builder.dart';

Future<void> main() async {
  /// make sure the glue that binds the framework to the Flutter engine
  /// is initialized.
  WidgetsFlutterBinding.ensureInitialized();

  /// initialize hive box of the theme mode
  await ThemeModeBuilderConfig.ensureInitialized(
    subDir: "Steps Tracker",
  );

  /// initialize easy localization
  await EasyLocalization.ensureInitialized();

  /// initialize locator (dependency injector)
  configureDependencies();

  /// initialize firebase
  await locator<FirebaseService>().init();

  /// Runs the app :)
  runApp(StepsTrackerApp());
}
