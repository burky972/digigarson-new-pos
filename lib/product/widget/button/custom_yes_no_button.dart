import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/widget/text/button_text/button_text.dart';
import 'package:flutter/material.dart';

class CustomYesButton extends StatelessWidget {
  const CustomYesButton({required this.onPressed, super.key});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: CustomButtonText(text: 'Yes', textColor: context.colorScheme.primary));
  }
}

class CustomNoButton extends StatelessWidget {
  const CustomNoButton({required this.onPressed, super.key});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: CustomButtonText(text: 'No', textColor: context.colorScheme.tertiary));
  }
}
