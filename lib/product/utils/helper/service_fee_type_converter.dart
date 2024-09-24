import 'package:a_pos_flutter/product/enums/service_type/enum.dart';

class ServiceFeeTypeConverter {
  const ServiceFeeTypeConverter._();

  static String getStringType(int type) {
    String savedType = switch (type) {
      1 => ServiceFeeType.AMOUNT.name,
      2 => ServiceFeeType.PERCENT.name,
      _ => throw Exception('Invalid type')
    };
    return savedType;
  }
}
