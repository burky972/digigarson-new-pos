import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/responsive/paddings.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:flutter/material.dart';

class LightBlueButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onTap;

  const LightBlueButton({
    super.key,
    required this.buttonText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const AppPadding.extraMinAll(),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 70,
          maxWidth: 85,
          minHeight: 25,
          maxHeight: 45,
        ),
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            disabledBackgroundColor: context.colorScheme.onSecondary,
            backgroundColor: context.colorScheme.onSecondary,
            foregroundColor: context.colorScheme.onSecondary,
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
              side: BorderSide(
                color: context.colorScheme.tertiary,
                width: 1.0,
              ),
            ),
            padding: EdgeInsets.zero,
          ),
          child: Center(
            child: Text(
              buttonText,
              textAlign: TextAlign.center,
              style: CustomFontStyle.buttonTextStyle.copyWith(
                color: context.colorScheme.primary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
