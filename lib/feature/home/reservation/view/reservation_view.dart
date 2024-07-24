import 'package:a_pos_flutter/feature/home/main/view/main_view.dart';
import 'package:a_pos_flutter/feature/home/reservation/view/widget/reservation_success_view.dart';
import 'package:a_pos_flutter/product/widget/calendar/calendar.dart';
import 'package:flutter/material.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/widget/button/exit_button.dart';
import 'package:table_calendar/table_calendar.dart';

class ReservationView extends StatefulWidget {
  const ReservationView({super.key});

  @override
  _ReservationViewState createState() => _ReservationViewState();
}

class _ReservationViewState extends State<ReservationView> {
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: context.dynamicHeight(0.75),
            child: Container(
              color: Colors.blue[100],
              child: CalendarView(
                selectedDay: _selectedDay,
                onDaySelected: (selectedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                  });
                },
              ),
            ),
          ),
          SizedBox(
            height: context.dynamicHeight(0.014),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                if (_selectedDay != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          ReservationSuccessView(selectedDate: _selectedDay!),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please select a date.')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(
                      vertical: context.dynamicWidth(0.014), horizontal: 32),
                  textStyle: TextStyle(
                    fontSize: context.dynamicWidth(0.012),
                    fontWeight: FontWeight.bold,
                  )),
              child: Text('Confirm Reservation'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ExitButton(
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const MainView())),
            ),
          ),
        ],
      ),
    );
  }
}
