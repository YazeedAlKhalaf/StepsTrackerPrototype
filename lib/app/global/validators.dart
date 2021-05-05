import 'package:steps_tracker/app/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

/// Validators file, each function validates a field

String? validateName(String name, bool first) {
  final String trimmedName = name.trim();
  final String firstOrLast = first
      ? LocaleKeys.validators_first.tr()
      : LocaleKeys.validators_last.tr();

  if (trimmedName.isEmpty) {
    return LocaleKeys.validators_cant_empty.tr(
      namedArgs: {
        "field": "$firstOrLast",
      },
    );
  } else if (trimmedName.length < 3) {
    return LocaleKeys.validators_more_characters.tr(
      namedArgs: {
        "field": "$firstOrLast",
        "characters": "3",
      },
    );
  } else if (trimmedName.length > 15) {
    return LocaleKeys.validators_less_characters.tr(
      namedArgs: {
        "field": "$firstOrLast",
        "characters": "15",
      },
    );
  } else {
    return null;
  }
}

String? validatePhoneNumber(String phoneNumber) {
  final String trimmedPhoneNumber = phoneNumber.trim();

  /// Regular expression match for Saudi phone number
  final RegExpMatch? phoneNumberMatch =
      RegExp(r"^(009665|9665|\+9665|05|5)(5|0|3|6|4|9|1|8|7)([0-9]{7})$")
          .firstMatch(trimmedPhoneNumber);

  if (trimmedPhoneNumber.isEmpty) {
    return LocaleKeys.validators_cant_empty.tr(
      namedArgs: {
        "field": "${LocaleKeys.validators_phone_number.tr()}",
      },
    );
  } else if (phoneNumber.length > 14) {
    return LocaleKeys.validators_less_characters.tr(
      namedArgs: {
        "field": "${LocaleKeys.validators_phone_number.tr()}",
        "characters": "14",
      },
    );
  } else if (phoneNumberMatch == null) {
    return LocaleKeys.validators_not_correct.tr(
      namedArgs: {
        "field": "${LocaleKeys.validators_phone_number.tr()}",
      },
    );
  } else {
    return null;
  }
}

String? validateVerificationCode(String verificationCode) {
  final String trimmedVerificationCode = verificationCode.trim();

  if (trimmedVerificationCode.isEmpty) {
    return LocaleKeys.validators_cant_empty.tr(
      namedArgs: {
        "field": "${LocaleKeys.validators_verification_code.tr()}",
      },
    );
  } else if (trimmedVerificationCode.length != 6) {
    return LocaleKeys.validators_must_be.tr(
      namedArgs: {
        "field": "${LocaleKeys.validators_verification_code.tr()}",
        "characters": "6",
      },
    );
  } else {
    return null;
  }
}
