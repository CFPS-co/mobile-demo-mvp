import 'package:cfps/domain/entities/transaction_type.dart';

TransactionType getTransactionTypeFor(int id) {
  if(id == 0) return TransactionType.income;
  if(id == 1) return TransactionType.internal;
  if(id == 2) return TransactionType.outcome;
  throw Exception();
}