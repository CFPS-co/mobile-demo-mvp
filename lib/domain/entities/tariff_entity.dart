import 'package:freezed_annotation/freezed_annotation.dart';

part 'tariff_entity.freezed.dart';

@freezed
class TariffEntity with _$TariffEntity {
  const factory TariffEntity({
    required String label,
    required String value,
  }) = _TariffEntity;
}
