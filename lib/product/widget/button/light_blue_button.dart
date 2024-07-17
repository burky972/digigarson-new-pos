import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/responsive/paddings.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:flutter/material.dart';

class LightBlueButton extends StatelessWidget {
  const LightBlueButton({super.key, required this.buttonText});

  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 70, maxWidth: 85, minHeight: 25, maxHeight: 45),
      margin: const AppPadding.extraMinAll(),
      decoration: BoxDecoration(
        color: context.colorScheme.onSecondary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
        border: Border.all(
          color: context.colorScheme.tertiary,
          width: 1.0,
        ),
      ),
      child: Center(
        child: Text(
          buttonText,
          style: CustomFontStyle.buttonTextStyle.copyWith(color: context.colorScheme.primary),
        ),
      ),
    );
  }
}
