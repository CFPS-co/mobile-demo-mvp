part of 'create_password_cubit.dart';

@freezed
class CreatePasswordState with _$CreatePasswordState {
  const factory CreatePasswordState.initial() = _Initial;

  const factory CreatePasswordState.loading() = _Loading;

  const factory CreatePasswordState.saved() = _Saved;

  const factory CreatePasswordState.fail(Failure failure) = _Fail;
}
