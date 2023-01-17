import 'package:cfps/domain/entities/transaction_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction.freezed.dart';

@freezed
class Transaction with _$Transaction {
  const factory Transaction({
    required int id,
    required double amount,
    required String merchantName,
    required DateTime time,
    required TransactionType type,
    required String sourceName,
    required String currency,
  }) = _Transaction;
}
