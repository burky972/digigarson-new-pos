import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:flutter/material.dart';

class CustomButtonText extends StatelessWidget {
  const CustomButtonText({super.key, required this.text, this.textColor});
  final String text;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: CustomFontStyle.buttonTextStyle.copyWith(color: textColor),
      textAlign: TextAlign.center,
    );
  }
}
