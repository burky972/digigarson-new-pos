import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:flutter/material.dart';

class FromToTitle extends StatelessWidget {
  const FromToTitle({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: context.dynamicWidth(0.05),
        child: Padding(
          padding: const EdgeInsets.only(left: 28.0),
          child: Text(
            title,
            style: CustomFontStyle.titlesTextStyle.copyWith(
              color: context.colorScheme.tertiary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ));
  }
}
