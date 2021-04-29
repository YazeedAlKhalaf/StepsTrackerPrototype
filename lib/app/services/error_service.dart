import 'package:firebase_auth/firebase_auth.dart';
import 'package:steps_tracker/app/models/k_error.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:steps_tracker/app/translations/locale_keys.g.dart';

class ErrorService {
  static KError handleUnknownErrors(dynamic exception) {
    print(exception);
    return KError(
      errorCode: "unknown",
      userFriendlyMessage: LocaleKeys.error_service_unknown.tr(),
    );
  }

  static KError handleFirebaseAuthExceptions(FirebaseAuthException exception) {
    print(
      "FirebaseAuthException => Code: ${exception.code} | Message: ${exception.message}",
    );

    switch (exception.code) {
      case "invalid-verification-id":
        return KError(
          errorCode: exception.code,
          userFriendlyMessage:
              LocaleKeys.error_service_invalid_verification_id.tr(),
        );
      case "invalid-verification-code":
        return KError(
          errorCode: exception.code,
          userFriendlyMessage:
              LocaleKeys.error_service_invalid_verification_code.tr(),
        );
      case "user-disabled":
        return KError(
          errorCode: exception.code,
          userFriendlyMessage: LocaleKeys.error_service_user_disabled.tr(),
        );
      default:
        return handleUnknownErrors(exception);
    }
  }

  static KError handleFirestoreExceptions(dynamic exception) {
    switch (exception.toString()) {
      default:
        return handleUnknownErrors(exception);
    }
  }
}
