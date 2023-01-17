part of 'login_with_pin_code_cubit.dart';

@freezed
class LoginWithPinCodeState with _$LoginWithPinCodeState {
  const factory LoginWithPinCodeState.auth({bool? authError}) = _Auth;

  const factory LoginWithPinCodeState.setPin() = _SetPin;

  const factory LoginWithPinCodeState.confirmPin() = _ConfirmPin;

  const factory LoginWithPinCodeState.pinsDontMatch() = _PinsDontMatch;

  const factory LoginWithPinCodeState.newPinSameAsCurrent() =
      _NewPinSameAsCurrent;

  const factory LoginWithPinCodeState.onError() = _OnError;

  const factory LoginWithPinCodeState.onSuccess() = _OnSuccess;
}
