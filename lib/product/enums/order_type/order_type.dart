// ignore_for_file: constant_identifier_names

enum OrderType {
  DINE_IN(1),
  TAKE_OUT(2),
  HOME_DELIVERY(3),
  QUICK_SERVICE(4),
  BAR(5);

  const OrderType(this.value);
  final int value;
}
