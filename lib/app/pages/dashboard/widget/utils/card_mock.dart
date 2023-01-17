class CardMock {
  CardMock({
    required this.cardName,
    required this.cardNumber,
    required this.balance,
    required this.imageUrl,
    required this.isBlocked,
    required this.currency,
    required this.isOrdered,
    required this.isReordered,
  });

  String cardName;
  String cardNumber;
  double balance;
  String imageUrl;
  bool isBlocked;
  bool isOrdered;
  bool isReordered;
  String currency;

  bool get hasNoBalance => balance == 0.00;

  bool get hasNegativeBalance => balance < 0.00;

  String get balanceString => '${balance.toStringAsFixed(2)} $currency';
}
