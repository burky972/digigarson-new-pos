import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/responsive/border.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:flutter/material.dart';

class TableButtonWidget extends StatelessWidget {
  const TableButtonWidget(this.label, {super.key});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (context.dynamicWidth(.32) + (context.dynamicWidth(.06) - 60)) / 4,
      constraints: const BoxConstraints(
        minWidth: 60,
        maxWidth: 110,
        minHeight: 55,
      ),
      decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius:
              const BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
          border: BorderConstants.borderAllSmall),
      child: Center(
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: CustomFontStyle.buttonTextStyle.copyWith(color: context.colorScheme.tertiary),
        ),
      ),
    );
  }
}
