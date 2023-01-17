enum TransactionCategory {
  shop,
  transfer,
}

class TransactionMock {
  TransactionMock({
    required this.balance,
    required this.shopName,
    required this.category,
    required this.cardType,
    required this.currency,
  });

  double balance;
  String shopName;
  TransactionCategory category;
  String cardType;
  String currency;

  bool get hasNoBalance => balance == 0.00;

  bool get hasNegativeBalance => balance < 0.00;

  String get balanceString =>
      hasNegativeBalance ? '${balance.toStringAsFixed(2)} $currency' : '+${balance.toStringAsFixed(2)} $currency';
}
