// ignore_for_file: constant_identifier_names

enum PaymentType {
  /// Kredi Kartı
  CREDIT_CARD(1),

  /// Nakit
  CASH(2);

  /// Bahşiş
  // TIP(3);

  final int value;

  const PaymentType(this.value);

  static List<PaymentType> get allTypes => [CREDIT_CARD, CASH];

  String getServerValue(int value) {
    switch (value) {
      case 1:
        return 'Credit Card';
      case 2:
        return 'Cash';
      // case 3:
      //   return 'Tip';
      default:
        return '';
    }
  }
}
