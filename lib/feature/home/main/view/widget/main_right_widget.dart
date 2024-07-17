import 'package:a_pos_flutter/feature/home/main/widget/main_right_widget/bottom_exit_button.dart';
import 'package:a_pos_flutter/feature/home/main/widget/main_right_widget/center_buttons_widget.dart';
import 'package:a_pos_flutter/feature/home/main/widget/main_right_widget/top_main_info.dart';
import 'package:a_pos_flutter/feature/home/main/widget/main_right_widget/top_right_close_buttons.dart';
import 'package:flutter/material.dart';

class MainRightWidget extends StatelessWidget {
  const MainRightWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        TopRightCloseButtons(),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TopMainInfo(),
            CenterButtonsWidget(),
            MainRightBottomExitButton(),
          ],
        )
      ],
    );
  }
}
