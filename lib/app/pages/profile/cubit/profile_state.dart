part of 'profile_cubit.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState.initial() = _Initial;

  const factory ProfileState.loading() = _Loading;

  const factory ProfileState.failure(Failure fail) = _Failure;

  const factory ProfileState.loaded({
    required ClientDetails clientDetails,
  }) = _Loaded;

  const factory ProfileState.logout() = _Logout;
}
