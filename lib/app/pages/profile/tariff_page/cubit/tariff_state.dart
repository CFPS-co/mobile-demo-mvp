part of 'tariff_cubit.dart';

@freezed
class TariffState with _$TariffState {
  const factory TariffState.initial() = _Initial;

  const factory TariffState.loading() = _Loading;

  const factory TariffState.error(Failure failure) = _Error;

  const factory TariffState.success(List<TariffEntity> list) = _Success;
}
