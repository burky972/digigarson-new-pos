// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:flutter/material.dart';

class CustomBorderAllTextfield extends StatelessWidget {
  const CustomBorderAllTextfield({
    super.key,
    required this.controller,
    required this.onChanged,
    this.isReadOnly = false,
    this.isObscure = false,
    this.validator,
    this.maxCharacter,
  });
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final bool isReadOnly;
  final bool isObscure;
  final String? Function(String?)? validator;
  final int? maxCharacter;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: isReadOnly,
      style: CustomFontStyle.formsTextStyle.copyWith(
        fontSize: context.dynamicWidth(0.008),
      ),
      validator: validator,
      obscureText: isObscure,
      controller: controller,
      onChanged: onChanged,
      decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
          border: OutlineInputBorder(borderSide: BorderSide(width: 2))),
    );
  }
}
