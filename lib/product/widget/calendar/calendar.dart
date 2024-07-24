import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarView extends StatelessWidget {
  final DateTime? selectedDay;
  final void Function(DateTime) onDaySelected;

  const CalendarView({
    Key? key,
    this.selectedDay,
    required this.onDaySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      rowHeight: context.dynamicHeight(0.094),
      daysOfWeekHeight: context.dynamicHeight(0.04),
      locale: 'en_US',
      firstDay: DateTime.utc(2024, 01, 01),
      lastDay: DateTime.utc(2100, 01, 01),
      focusedDay: DateTime.now(),
      selectedDayPredicate: (day) {
        return isSameDay(selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        onDaySelected(selectedDay);
      },
      calendarFormat: CalendarFormat.month,
      startingDayOfWeek: StartingDayOfWeek.monday,
      headerStyle: HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
        leftChevronIcon: Icon(
          Icons.keyboard_double_arrow_left,
          color: Colors.red,
          size: context.dynamicHeight(0.06),
        ),
        rightChevronIcon: Icon(
          Icons.keyboard_double_arrow_right,
          color: Colors.red,
          size: context.dynamicHeight(0.06),
        ),
        titleTextStyle: TextStyle(
          color: Color.fromARGB(255, 2, 0, 143),
          fontSize: context.dynamicHeight(0.04),
          fontWeight: FontWeight.bold,
        ),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: context.dynamicHeight(0.02),
        ),
        weekendStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: context.dynamicHeight(0.02),
        ),
      ),
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        defaultDecoration: BoxDecoration(
          color: Colors.green,
          shape: BoxShape.rectangle,
        ),
        weekendDecoration: BoxDecoration(
          color: Colors.green,
          shape: BoxShape.rectangle,
        ),
        defaultTextStyle: TextStyle(
          fontSize: context.dynamicHeight(0.02),
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        weekendTextStyle: TextStyle(
          fontSize: context.dynamicHeight(0.02),
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        todayTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: context.dynamicHeight(0.02),
        ),
        selectedTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: context.dynamicHeight(0.02),
        ),
        todayDecoration: BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.rectangle,
        ),
        selectedDecoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.rectangle,
        ),
      ),
    );
  }
}
