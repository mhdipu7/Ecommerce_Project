import 'package:crafty_bay/Presentation/ui/utils/regex/regex_patterns.dart';

class PhoneNumberValidator {
  static bool validatePhoneNumber(String phoneNumber) {
    return RegexPatterns.phoneNumberRegExp.hasMatch(phoneNumber);
  }
}
