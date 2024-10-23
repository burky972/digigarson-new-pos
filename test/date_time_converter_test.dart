import 'package:a_pos_flutter/product/utils/helper/date_helper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late DateTime dateTime;

  setUp(() {
    dateTime = DateTime.now();
  });

  test('Date time type control', () {
    int timestamp = DateHelper.toTimestamp(dateTime);
    DateTime convertedDateTime = DateHelper.fromTimestamp(timestamp);
    expect(timestamp, isA<int>());
    expect(convertedDateTime, isA<DateTime>());
  });

  test('Date time converter', () {
    DateTime normalDate = DateHelper.normalize(dateTime);
    int timestamp = DateHelper.toTimestamp(normalDate);
    DateTime convertedDateTime = DateHelper.fromTimestamp(timestamp);
    expect(normalDate, convertedDateTime);
  });
}
// final timestamp = DateTime.now().toUtc().millisecondsSinceEpoch;