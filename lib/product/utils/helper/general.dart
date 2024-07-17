import 'package:a_pos_flutter/product/global/model/order/new_order_model.dart';

getOptionString(List<NewOrderItem> items) {
  if (items.isEmpty) {
    return "";
  }

  StringBuffer buffer = StringBuffer();

  for (int i = 0; i < items.length; i++) {
    NewOrderItem item = items[i];

    buffer.write(item.name.toString());

    if (i < items.length - 1) {
      buffer.write(", ");
    } else {
      buffer.write(".");
    }
  }
  return buffer.toString();
}

getOptionProductString(String rawData) {
  if (rawData.endsWith("-")) {
    rawData = rawData.substring(0, rawData.length - 2);
  }
  return "$rawData.";
}
