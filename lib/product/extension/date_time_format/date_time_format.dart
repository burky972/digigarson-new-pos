import 'package:a_pos_flutter/product/constant/app/date_time_formats.dart';
import 'package:easy_localization/easy_localization.dart';

extension DateTimeFormat on DateTime {
  String toFormattedString({String format = dateTimeFormatWoSecond}) {
    return DateFormat(format).format(this);
  }
}
