part of 'kyc_cubit.dart';

@freezed
class KycState with _$KycState {
  const factory KycState.initial() = _Initial;

  const factory KycState.loading() = _Loading;

  const factory KycState.loaded() = _Loaded;
}
