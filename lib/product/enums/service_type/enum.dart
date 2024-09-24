// ignore_for_file: constant_identifier_names

enum ServiceFeeType {
  /// 1
  AMOUNT(1),

  /// 2
  PERCENT(2);

  final int value;

  const ServiceFeeType(this.value);
}
