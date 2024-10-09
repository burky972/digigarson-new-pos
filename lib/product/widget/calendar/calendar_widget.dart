import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/responsive/paddings.dart';
import 'package:a_pos_flutter/product/theme/custom_calendar_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  late CalendarFormat _calendarFormat;
  late DateTime _focusedDay;
  late DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    _calendarFormat = CalendarFormat.month;
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const AppPadding.normalAll(),
      child: Container(
        color: Colors.lightBlue[50],
        child: TableCalendar(
          firstDay: DateTime.utc(0000, 1, 1),
          lastDay: DateTime.utc(9999, 12, 31),
          focusedDay: _focusedDay,
          calendarFormat: _calendarFormat,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          },
          onFormatChanged: (format) {
            setState(() {
              _calendarFormat = format;
            });
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
          calendarStyle: CustomCalendarTheme.getCalendarStyle(context),
          headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextFormatter: (date, locale) => DateFormat('MM/yyyy').format(date),
              titleTextStyle: TextStyle(
                fontSize: 32,
                color: context.colorScheme.tertiary,
                fontWeight: FontWeight.bold,
              ),
              leftChevronIcon: const _ForwardBackwardButton(isForward: false),
              rightChevronIcon: const _ForwardBackwardButton()),
          calendarBuilders: CalendarBuilders(
            defaultBuilder: (context, day, focusedDay) {
              return Container(
                margin: const EdgeInsets.all(4),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: day.isBefore(DateTime.now()) ? Colors.green[100] : null,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  day.day.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              );
            },
          ),
          availableGestures: AvailableGestures.all,
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: TextStyle(
              color: context.colorScheme.tertiary,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
            weekendStyle: TextStyle(
              color: context.colorScheme.tertiary,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          locale: 'en_US',
          daysOfWeekHeight: 40,
          rowHeight: 90,
        ),
      ),
    );
  }
}

class _ForwardBackwardButton extends StatelessWidget {
  const _ForwardBackwardButton({this.isForward = true});
  final bool isForward;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.tertiary,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.all(24),
      child: Icon(
        isForward ? Icons.chevron_right : Icons.chevron_left,
        size: 30,
      ),
    );
  }
}
