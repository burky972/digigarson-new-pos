import 'package:a_pos_flutter/feature/back_office/menu/sub_view/option/model/option_model.dart';

getOptionString(List<Item> items) {
  if (items.isEmpty) {
    return "";
  }

  StringBuffer buffer = StringBuffer();

  for (int i = 0; i < items.length; i++) {
    Item item = items[i];

    buffer.write(item.itemName.toString());

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
