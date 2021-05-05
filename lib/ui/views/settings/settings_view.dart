import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:steps_tracker/app/locator/locator.dart';
import 'package:steps_tracker/app/router/router.dart';
import 'package:steps_tracker/app/services/localization_service.dart';
import 'package:steps_tracker/app/services/router_service.dart';
import 'package:steps_tracker/ui/views/settings/widgets/appearance_tile.dart';
import 'package:steps_tracker/ui/views/settings/widgets/language_tile.dart';
import 'package:theme_mode_builder/theme_mode_builder.dart';

import 'package:steps_tracker/app/translations/locale_keys.g.dart';
import 'package:steps_tracker/ui/views/settings/settings_view_model.dart';
import 'package:steps_tracker/ui/views/settings/widgets/settings_section.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => SettingsViewModel(),
      builder: (
        BuildContext context,
        SettingsViewModel model,
        Widget? child,
      ) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              LocaleKeys.views_settings_settings.tr(),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SettingsSection(
                    title: LocaleKeys.views_settings_appearance.tr(),
                    children: <Widget>[
                      AppearanceTile(
                        icon: FontAwesomeIcons.sun,
                        text: LocaleKeys.views_settings_light.tr(),
                        onTap: () async {
                          ThemeModeBuilderConfig.setLight();
                          model.notifyListeners();
                        },
                        isActive: ThemeModeBuilderConfig.getThemeMode() ==
                            ThemeMode.light,
                      ),
                      AppearanceTile(
                        icon: FontAwesomeIcons.moon,
                        text: LocaleKeys.views_settings_dark.tr(),
                        onTap: () async {
                          ThemeModeBuilderConfig.setDark();
                          model.notifyListeners();
                        },
                        isActive: ThemeModeBuilderConfig.getThemeMode() ==
                            ThemeMode.dark,
                      ),
                      AppearanceTile(
                        icon: FontAwesomeIcons.mobileAlt,
                        text: LocaleKeys.views_settings_system.tr(),
                        onTap: () async {
                          ThemeModeBuilderConfig.setSystem();
                          model.notifyListeners();
                        },
                        isActive: ThemeModeBuilderConfig.getThemeMode() ==
                            ThemeMode.system,
                      ),
                    ],
                  ),
                  SettingsSection(
                    title: LocaleKeys.views_settings_language.tr(),
                    children: <Widget>[
                      LanguageTile(
                        emoji: "🇬🇧",
                        title: "English",
                        showCheck: context.locale == const Locale("en"),
                        onTap: context.locale == const Locale("en")
                            ? () {}
                            : () async {
                                await locator<LocalizationService>()
                                    .changeLocale(
                                  context,
                                  SupportedLocales.en,
                                );

                                await locator<RouterService>()
                                    .router
                                    .pushAndPopUntil(
                                      StartupRoute(),
                                      predicate: (_) => false,
                                    );
                              },
                      ),
                      LanguageTile(
                        emoji: "🇸🇦",
                        title: "العربية",
                        showCheck: context.locale == const Locale("ar"),
                        onTap: context.locale == const Locale("ar")
                            ? () {}
                            : () async {
                                await locator<LocalizationService>()
                                    .changeLocale(
                                  context,
                                  SupportedLocales.ar,
                                );

                                await locator<RouterService>()
                                    .router
                                    .pushAndPopUntil(
                                      StartupRoute(),
                                      predicate: (_) => false,
                                    );
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
