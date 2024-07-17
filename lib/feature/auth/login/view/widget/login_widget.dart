import 'package:a_pos_flutter/gen/assets.gen.dart';
import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/responsive/paddings.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:flutter/material.dart';

class TopLogoWidget extends StatelessWidget {
  const TopLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        height: context.dynamicHeight(.1),
        child: Assets.icon.icLogo.image(),
      ),
    );
  }
}

class LoginBottomExitButton extends StatelessWidget {
  const LoginBottomExitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
          padding: const AppPadding.xLargeAll(),
          decoration: BoxDecoration(
              color: context.colorScheme.tertiary, borderRadius: BorderRadius.circular(24)),
          child: Text(
            'EXIT',
            style: CustomFontStyle.buttonTextStyle.copyWith(
              color: Colors.white,
            ),
          )),
    );
  }
}
