/// Validators file, each function validates a field

String validateName(String name, bool first) {
  final String trimmedName = name.trim();
  final String firstOrLast = first ? "First" : "Last";

  if (trimmedName.isEmpty) {
    return "$firstOrLast name can't be empty.";
  } else if (trimmedName.length < 3) {
    return "$firstOrLast name must be more than 3 characters.";
  } else if (trimmedName.length > 15) {
    return "$firstOrLast name must be less than 15 characters.";
  } else {
    return null;
  }
}

String validatePhoneNumber(String phoneNumber) {
  final String trimmedPhoneNumber = phoneNumber.trim();

  /// Regular expression match for Saudi phone number
  final RegExpMatch phoneNumberMatch =
      RegExp(r"^(009665|9665|\+9665|05|5)(5|0|3|6|4|9|1|8|7)([0-9]{7})$")
          .firstMatch(trimmedPhoneNumber);

  if (trimmedPhoneNumber.isEmpty) {
    return "Phone Number can't be empty.";
  } else if (phoneNumber.length > 14) {
    return "Phone Number can't be more than 14 characters.";
  } else if (phoneNumberMatch == null) {
    return "Phone Number is not correct.";
  } else {
    return null;
  }
}

String validateVerificationCode(String verificationCode) {
  final String trimmedVerificationCode = verificationCode.trim();

  if (trimmedVerificationCode.isEmpty) {
    return "Verification Code can't be empty.";
  } else if (trimmedVerificationCode.length != 6) {
    return "Verification Code must be 6 characters.";
  } else {
    return null;
  }
}
