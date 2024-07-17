import 'package:a_pos_flutter/product/responsive/paddings.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  Function? onTap;
  final String? buttonText;
  final bool isBuy;
  final bool isBorder;
  final double heightBtn;
  final double paddingBtn;
  final LinearGradient? linearGradient;
  final Color buttonColor;
  final Color textColor;

  CustomButton({
    super.key,
    this.onTap,
    required this.buttonText,
    this.isBuy = false,
    this.isBorder = false,
    this.heightBtn = 45,
    this.paddingBtn = 0.0,
    this.linearGradient,
    this.buttonColor = const Color(0xFFebebeb),
    this.textColor = const Color(0xffff6347),
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          onTap!();
        },
        style: TextButton.styleFrom(padding: const AppPadding()),
        child: Container(
          height: heightBtn,
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: paddingBtn, right: paddingBtn),
          decoration: BoxDecoration(
              color: buttonColor,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: const Offset(0, 1)),
              ],
              borderRadius: BorderRadius.circular(isBorder ? 4 : 6)),
          child: Text(buttonText!,
              style: CustomFontStyle.buttonTextStyle.copyWith(fontSize: 16, color: textColor)),
        ));
  }
}
