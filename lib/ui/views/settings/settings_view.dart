import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:steps_tracker/ui/views/settings/settings_view_model.dart';
import 'package:steps_tracker/ui/views/settings/widgets/settings_section.dart';
import 'package:theme_mode_builder/theme_mode_builder.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => SettingsViewModel(),
      builder: (
        BuildContext context,
        SettingsViewModel model,
        Widget child,
      ) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Settings",
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SettingsSection(
                    title: "Appearance",
                    children: <Widget>[
                      ListTile(
                        leading: Icon(
                          FontAwesomeIcons.sun,
                          size: 30,
                        ),
                        title: Text("Light"),
                        onTap: () async {
                          ThemeModeBuilderConfig.setLight();
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          FontAwesomeIcons.moon,
                          size: 30,
                        ),
                        title: Text("Dark"),
                        onTap: () async {
                          ThemeModeBuilderConfig.setDark();
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          FontAwesomeIcons.mobileAlt,
                          size: 30,
                        ),
                        title: Text("System"),
                        onTap: () async {
                          ThemeModeBuilderConfig.setSystem();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
