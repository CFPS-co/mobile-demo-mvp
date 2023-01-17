class RegularExpressions {
  /// Allowed pattern => x@x.x
  static const emailValidationRegExp = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  /// Allowed only digits
  static const digitsOnlyRegExp = '[0-9]+';
  /// Min 8 chars, 1 upper case, 1 digit, 1 special char
  static const passwordRegExp = r"^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{8,})";
}
