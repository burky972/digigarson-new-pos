import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/responsive/paddings.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:flutter/material.dart';

class ExitButton extends StatelessWidget {
  const ExitButton({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () => onPressed(),
        child: Container(
            width: context.dynamicWidth(0.1),
            padding: const AppPadding.xLargeAll(),
            decoration: BoxDecoration(
                color: context.colorScheme.tertiary, borderRadius: BorderRadius.circular(24)),
            child: Center(
              child: Text(
                'EXIT',
                style: CustomFontStyle.buttonTextStyle.copyWith(color: Colors.white, fontSize: 24),
              ),
            )),
      ),
    );
  }
}
