import 'package:flutter/material.dart';

class Utils {
  static String formatPhoneNumber({
    @required String phoneNumber,
  }) {
    String phoneNumberFormatted = phoneNumber;
    if (phoneNumber.startsWith("009665")) {
      final List<String> phoneNumberSplit = phoneNumber.split("009665");
      phoneNumberFormatted = "+9665${phoneNumberSplit[1]}";
    } else if (phoneNumber.startsWith("9665")) {
      final List<String> phoneNumberSplit = phoneNumber.split("9665");
      phoneNumberFormatted = "+9665${phoneNumberSplit[1]}";
    } else if (phoneNumber.startsWith("+9665")) {
      final List<String> phoneNumberSplit = phoneNumber.split("+9665");
      phoneNumberFormatted = "+9665${phoneNumberSplit[1]}";
    } else if (phoneNumber.startsWith("05")) {
      final List<String> phoneNumberSplit = phoneNumber.split("05");
      phoneNumberFormatted = "+9665${phoneNumberSplit[1]}";
    } else if (phoneNumber.startsWith("5")) {
      final List<String> phoneNumberSplit = phoneNumber.split("5");
      phoneNumberFormatted = "+9665${phoneNumberSplit[1]}";
    }
    print("Phone number before formatting: $phoneNumber");
    print("Phone number after formatting: $phoneNumberFormatted");
    return phoneNumberFormatted;
  }
}
