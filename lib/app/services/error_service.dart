import 'package:firebase_auth/firebase_auth.dart';
import 'package:steps_tracker/app/models/k_error.dart';

class ErrorService {
  static KError handleUnknownErrors(dynamic exception) {
    print(exception);
    return KError(
      errorCode: "unknown",
      userFriendlyMessage: "Something went wrong! Please try again later.",
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
          userFriendlyMessage: "Invalid verification ID.",
        );
      case "invalid-verification-code":
        return KError(
          errorCode: exception.code,
          userFriendlyMessage: "Invalid verification code.",
        );
      case "user-disabled":
        return KError(
          errorCode: exception.code,
          userFriendlyMessage: "Your account is disabled.",
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
