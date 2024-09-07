import 'package:a_pos_flutter/feature/auth/login/view/login_view.dart';

import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/responsive/border.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:a_pos_flutter/product/widget/button/custom_yes_no_button.dart';
import 'package:flutter/material.dart';

class MainRightBottomExitButton extends StatelessWidget {
  const MainRightBottomExitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.dynamicHeight(.08),
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: const Text('Are you sure you want to close this window?'),
                actions: [
                  CustomNoButton(onPressed: () => Navigator.of(context).pop()),
                  CustomYesButton(onPressed: () {
                    Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (_) => const LoginView()), (route) => false);
                  })
                ],
              );
            },
          );
        },
        child: Container(
          width: context.dynamicWidth(.15),
          decoration: BoxDecoration(
              color: context.colorScheme.onSurface,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              border: BorderConstants.borderAllSmall),
          child: Center(
            child: Text(
              "EXIT",
              style: CustomFontStyle.buttonTextStyle.copyWith(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
