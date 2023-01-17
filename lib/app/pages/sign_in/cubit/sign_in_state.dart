part of 'sign_in_cubit.dart';

@freezed
class SignInState with _$SignInState {
  const factory SignInState.initial() = _Initial;

  const factory SignInState.loading() = _Loading;

  const factory SignInState.error(Failure failure) = _Error;

  const factory SignInState.success() = _Success;

  const factory SignInState.wrongPassword() = _WrongPassword;

  const factory SignInState.userNotExist() = _UserNotExist;
}
