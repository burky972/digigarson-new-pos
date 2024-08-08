import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/responsive/border.dart';
import 'package:a_pos_flutter/product/responsive/paddings.dart';
import 'package:a_pos_flutter/product/widget/text/button_text/button_text.dart';
import 'package:flutter/material.dart';

class MainRightButton extends StatelessWidget {
  const MainRightButton({super.key, required this.text, this.isLightPurple = true});
  final String text;
  final bool isLightPurple;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.dynamicWidth(.08),
      constraints: const BoxConstraints(
        minHeight: 70,
      ),
      padding: const AppPadding.extraMinAll(),
      decoration: BoxDecoration(
          color:
              isLightPurple ? context.colorScheme.tertiary : context.colorScheme.onSurfaceVariant,
          borderRadius:
              const BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
          border: BorderConstants.borderAllSmall),
      child: Center(
          child: CustomButtonText(
        text: text,
        textColor: context.colorScheme.surface,
      )),
    );
  }
}
