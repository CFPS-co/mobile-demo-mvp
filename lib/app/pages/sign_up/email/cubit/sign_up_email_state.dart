part of 'sign_up_email_cubit.dart';

@freezed
class SignUpEmailState with _$SignUpEmailState {
  const factory SignUpEmailState.initial() = _Initial;

  const factory SignUpEmailState.clientAlreadyRegistered() = _ClientAlreadyRegistered;

  const factory SignUpEmailState.onSuccess({required String verificationCode, required String email}) = _OnSuccess;

  const factory SignUpEmailState.onError() = _OnError;
}
