import 'package:a_pos_flutter/feature/back_office/launch/view/back_office_launch_view.dart';
import 'package:a_pos_flutter/feature/home/main/widget/main_right_widget/main_right_button.dart';
import 'package:a_pos_flutter/feature/home/reopen/view/re_open_view.dart';
import 'package:a_pos_flutter/feature/home/reservation/view/reservation_view.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:flutter/material.dart';

class CenterButtonsWidget extends StatelessWidget {
  const CenterButtonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.dynamicHeight(.7),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const MainRightButton(text: 'Take Out'),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const ReOpenView()));
                },
                child: const MainRightButton(text: 'Re-Open'),
              ),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MainRightButton(text: 'Pick Up'),
              MainRightButton(text: 'Expense'),
            ],
          ),
          //!TODO: create custom widget and delete all same decoration codes!
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () async {},
                child: const MainRightButton(text: 'Delivery'),
              ),
              const MainRightButton(text: 'Open Drawer')
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {},
                child: const MainRightButton(text: 'Quick Service'),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const ReservationView()));
                },
                child: const MainRightButton(text: 'Reservation'),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {},
                child: const MainRightButton(text: 'Bar'),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const BackOfficeLaunchView()));
                },
                child: const MainRightButton(text: 'Back Office'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const MainRightButton(text: 'Waiter Report'),
              Container(
                width: context.dynamicWidth(.08),
                constraints: const BoxConstraints(
                  minHeight: 70,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
