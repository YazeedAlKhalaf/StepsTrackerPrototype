import "package:meta/meta.dart";

class KError {
  final String errorCode;
  final String userFriendlyMessage;

  KError({
    @required this.errorCode,
    @required this.userFriendlyMessage,
  });
}
