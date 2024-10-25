import 'package:crafty_bay/Presentation/ui/utils/regex/regex_patterns.dart';

class PostCodeValidator {
  static bool validatePostCode(String postCode) {
    return RegexPatterns.postCodeRegExp.hasMatch(postCode);
  }
}
