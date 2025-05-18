class CreditCard {
  final String number;
  final String holder;
  final String expiry;
  final String type; // 'Visa', 'MasterCard', 'ApplePay'

  CreditCard({
    required this.number,
    required this.holder,
    required this.expiry,
    required this.type,
  });
}
