import 'package:a_pos_flutter/feature/home/main/view/main_view.dart';
import 'package:a_pos_flutter/product/widget/button/exit_button.dart';
import 'package:flutter/material.dart';

class ReservationSuccessView extends StatelessWidget {
  final DateTime selectedDate;

  const ReservationSuccessView({super.key, required this.selectedDate});


  @override
  Widget build(BuildContext context) {
    final String formattedDate = DateFormatter.formatDate(selectedDate);
    
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Selected Date: $formattedDate',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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

class DateFormatter {
  static String formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}