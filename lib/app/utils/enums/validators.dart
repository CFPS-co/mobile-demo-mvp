import 'package:cfps/app/utils/regular_expressions.dart';

enum ValidationError {
  /// [Password]
  passwordIsRequired,
  passwordInvalid,
  passwordsNotMatch,
  wrongPassword,
  fieldIsRequired,
  invalidPassword,
  passwordTooShort,

  /// [Email]
  invalidEmail,
  emailTaken,

  /// [Dashboard]
  amountTooShort,
  amountTooHigh,
  moreThanBalance,
  userNotFound,
}

class Validators {
  static final _passwordRegex = RegExp(RegularExpressions.passwordRegExp);

  static ValidationError? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return ValidationError.passwordIsRequired;
    }
    if (value.length < 8) {
      return ValidationError.passwordTooShort;
    }

    if (_passwordRegex.hasMatch(value)) {
      return null;
    }

    return ValidationError.passwordInvalid;
  }

  static ValidationError? validateConfirmPassword(String? passwordConfirmation, String? password) {
    if (passwordConfirmation == null || passwordConfirmation.isEmpty) {
      return ValidationError.passwordIsRequired;
    }
    if (passwordConfirmation.length < 8) {
      return ValidationError.passwordTooShort;
    }

    if (password != passwordConfirmation) {
      return ValidationError.passwordsNotMatch;
    }

    return null;
  }
}
