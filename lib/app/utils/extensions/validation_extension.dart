import 'package:cfps/app/utils/enums/validators.dart';
import 'package:cfps/app/utils/translations/generated/l10n.dart';
import 'package:flutter/material.dart';

extension ValidationExtension on ValidationError {
  String message(BuildContext context) {
    switch (this) {
      case ValidationError.amountTooHigh:
        return Translation.of(context).youPutMoreMoneyThanYouHave;
      case ValidationError.passwordTooShort:
        return Translation.of(context).passwordTooShort;
      case ValidationError.passwordIsRequired:
        return Translation.of(context).passwordIsRequired;
      case ValidationError.wrongPassword:
        return Translation.of(context).wrongPassword;
      case ValidationError.passwordsNotMatch:
        return Translation.of(context).passwordsNotMatch;
      case ValidationError.fieldIsRequired:
        return Translation.of(context).fieldIsRequired;
      case ValidationError.invalidEmail:
        return Translation.of(context).invalidEmail;
      case ValidationError.emailTaken:
        return Translation.of(context).thisEmailIsAlreadyRegistered;
      case ValidationError.passwordInvalid:
        return Translation.of(context).passwordIsInvalid;
      case ValidationError.userNotFound:
        return Translation.of(context).clientDoesntExist;
      default:
        return Translation.of(context).fieldIsRequired;
    }
  }
}
