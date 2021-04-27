import 'package:flutter/material.dart';
import 'package:steps_tracker/app/locator/locator.dart';
import 'package:steps_tracker/app/services/router_service.dart';
import 'package:steps_tracker/app/utils/colors.dart';
import 'package:theme_mode_builder/theme_mode_builder.dart';

class StepsTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RouterService _routerService = locator<RouterService>();

    return ThemeModeBuilder(
      builder: (BuildContext context, ThemeMode themeMode) {
        return MaterialApp.router(
          themeMode: themeMode,
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: KColors.orange,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            accentColor: KColors.orange,
          ),
          routerDelegate: _routerService.router.delegate(),
          routeInformationParser: _routerService.router.defaultRouteParser(),
          builder: (BuildContext context, Widget child) {
            return GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus.unfocus();
              },
              child: child,
            );
          },
        );
      },
    );
  }
}
