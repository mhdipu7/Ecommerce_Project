import 'package:crafty_bay/Presentation/ui/utils/regex/regex_patterns.dart';

class FaxNumberValidator {
  static bool validateFaxNumber(String faxNumber) {
    return RegexPatterns.faxNumberRegExp.hasMatch(faxNumber);
  }
}
