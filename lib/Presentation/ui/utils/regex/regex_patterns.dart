class RegexPatterns {
  static RegExp emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  static final RegExp postCodeRegExp = RegExp(r'^\d{4,6}$');
  static RegExp phoneNumberRegExp = RegExp(r'^(?:\+?88)?01[3-9]\d{8}$');
  static RegExp faxNumberRegExp = RegExp(r'^(?:\+?88)?01[3-9]\d{8}$');
  static final RegExp otpRegExp = RegExp(r'^\d{6}$');
}
