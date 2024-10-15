import 'package:a_pos_flutter/product/constant/app/date_time_formats.dart';
import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/extension/date_time_format/date_time_format.dart';
import 'package:a_pos_flutter/product/responsive/paddings.dart';
import 'package:a_pos_flutter/product/theme/custom_calendar_theme.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:window_manager/window_manager.dart';

class _CalendarWidgetState extends State<CalendarWidget> with _CalendarMixin {
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
              titleTextFormatter: (date, locale) => date.toFormattedString(format: timeMonthYear),
              titleTextStyle: CustomCalendarTheme.titleStyle(context),
              leftChevronIcon: const _ForwardBackwardButton(isForward: false),
              rightChevronIcon: const _ForwardBackwardButton()),
          calendarBuilders: CalendarBuilders(
            defaultBuilder: (context, day, focusedDay) {
              return Container(
                margin: const EdgeInsets.all(2),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: day.isBefore(DateTime.now()) ? Colors.green[100] : null,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  day.day.toString(),
                  style: CustomCalendarTheme.calendarNumberStyle,
                ),
              );
            },
          ),
          availableGestures: AvailableGestures.all,
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: CustomCalendarTheme.weekendTextStyle(context),
            weekendStyle: CustomCalendarTheme.weekendTextStyle(context),
          ),
          locale: 'en_US',
          daysOfWeekHeight: 40,
          rowHeight: _rowHeight,
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

mixin _CalendarMixin on State<CalendarWidget> {
  late CalendarFormat _calendarFormat;
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  bool isFullScreen = false;

  @override
  void initState() {
    super.initState();
    _calendarFormat = CalendarFormat.month;
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
    checkIsFullScreen();
  }

  Future<void> checkIsFullScreen() async {
    bool isPreventClose = await windowManager.isFullScreen();
    isFullScreen = isPreventClose;
    setState(() {});
  }

  double get _rowHeight => isFullScreen ? 90 : 52.0;
}

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}
