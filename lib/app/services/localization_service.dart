import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'package:steps_tracker/app/locator/locator.dart';
import 'package:steps_tracker/app/services/auth_service.dart';
import 'package:steps_tracker/app/services/firestore_service.dart';

enum SupportedLocales {
  en,
  ar,
}

// ignore: missing_return
String convertLanguageEnumToString(SupportedLocales language) {
  switch (language) {
    case SupportedLocales.en:
      return "en";
    case SupportedLocales.ar:
      return "ar";
  }
}

// ignore: missing_return
SupportedLocales convertStringToLanguageEnum(String languageString) {
  switch (languageString) {
    case "en":
      return SupportedLocales.en;
    case "ar":
      return SupportedLocales.ar;
  }
}

@lazySingleton
class LocalizationService {
  final AuthService _authService = locator<AuthService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();

  Future<void> changeLocale(
    BuildContext context,
    SupportedLocales newLocale,
  ) async {
    Locale locale;
    switch (newLocale) {
      case SupportedLocales.en:
        locale = const Locale("en");
        break;
      case SupportedLocales.ar:
        locale = const Locale("ar");
        break;
      default:
        locale = const Locale("en");
        break;
    }

    await EasyLocalization.of(context).setLocale(locale);
    await _firestoreService.updateUserLanguage(
      userId: _authService.currentFirebaseUser.uid,
      newLanguage: newLocale,
    );
  }
}
