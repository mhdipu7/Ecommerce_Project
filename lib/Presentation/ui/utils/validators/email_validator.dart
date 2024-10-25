import 'package:crafty_bay/Presentation/ui/utils/regex/regex_patterns.dart';

class EmailValidator {
  static bool validateEmail(String email) {
    return RegexPatterns.emailRegExp.hasMatch(email);
  }
}
