import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

@immutable
final class CustomCalendarTheme {
  const CustomCalendarTheme._();

  static CalendarStyle getCalendarStyle(BuildContext context) {
    return CalendarStyle(
      todayDecoration: _todayDecoration(context),
      todayTextStyle:
          const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
      selectedDecoration: _selectedDecoration,
      selectedTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
      defaultDecoration: _weekDecoration,
      weekendDecoration: _weekDecoration,
      outsideDecoration: _outsideDecoration,
    );
  }

  static _todayDecoration(BuildContext context) => BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(5),
        color: context.colorScheme.tertiary,
      );

  static BoxDecoration get _selectedDecoration => BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.green,
        borderRadius: BorderRadius.circular(5),
      );

  static BoxDecoration get _weekDecoration => BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey),
      );

  static BoxDecoration get _outsideDecoration => BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(5),
      );
}
