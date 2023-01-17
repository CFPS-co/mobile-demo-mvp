part of 'sign_up_code_verification_cubit.dart';

@freezed
class SignUpCodeVerificationState with _$SignUpCodeVerificationState {
  const factory SignUpCodeVerificationState.initial() = _Initial;

  const factory SignUpCodeVerificationState.codeMismatch() = _CodeMismatch;

  const factory SignUpCodeVerificationState.tooManyAttempts() = _TooManyAttempts;

  const factory SignUpCodeVerificationState.onSuccess({
    required SignUpArguments arguments,
  }) = _OnSuccess;
}
