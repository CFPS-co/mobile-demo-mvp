import 'package:cfps/domain/entities/cfps_card.dart';
import 'package:cfps/domain/entities/transaction.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'client_details.freezed.dart';

@freezed
class ClientDetails with _$ClientDetails {
  const factory ClientDetails({
    required String email,
    required double accountBalance,
    required String name,
    required String? phone,
    required List<CfpsCard> cards,
    required List<Transaction> lastTransactions,
  }) = _ClientDetails;
}