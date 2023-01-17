import 'package:freezed_annotation/freezed_annotation.dart';

part 'cfps_card.freezed.dart';

@freezed
class CfpsCard with _$CfpsCard {
  const CfpsCard._();

  const factory CfpsCard({
    required double balance,
    required String name,
    required String number,
    required String imageUrl,
    required bool isBlocked,
    required bool isOrdered,
    required bool isReordered,
    required String currency,
  }) = _CfpsCard;

  bool get hasNoBalance => balance == 0.0;

  bool get hasNegativeBalance => balance < 0.00;

  String get balanceString => '${balance.toStringAsFixed(2)} $currency';
}
