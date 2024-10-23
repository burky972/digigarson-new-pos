import 'package:a_pos_flutter/product/constant/app/date_time_formats.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

@immutable
final class DateHelper {
  const DateHelper._();

  /// Convert string formatted date to timestamp
  static int stringToTimestamp(String dateStr) {
    try {
      final DateFormat formatter = DateFormat(timeFormatMDY);
      final DateTime dateTime = formatter.parse(dateStr);
      return dateTime.millisecondsSinceEpoch;
    } catch (e) {
      throw const FormatException('Geçersiz tarih formatı. Beklenen format: MM/dd/yyyy');
    }
  }

  // Round DateTime to millisecond precision
  static DateTime normalize(DateTime dateTime) {
    return DateTime.fromMillisecondsSinceEpoch(dateTime.millisecondsSinceEpoch);
  }

  // Convert DateTime to timestamp (in milliseconds)
  static int toTimestamp(DateTime dateTime) {
    return dateTime.millisecondsSinceEpoch;
  }

  // Convert timestamp to DateTime
  static DateTime fromTimestamp(int timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }
}
