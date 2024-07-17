import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:flutter/material.dart';

class CustomPasswordTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintTxt;
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final TextInputAction? textInputAction;
  final Function()? onTap;

  const CustomPasswordTextField(
      {super.key,
      this.controller,
      this.hintTxt,
      this.focusNode,
      this.nextNode,
      this.textInputAction,
      this.onTap});

  @override
  State<CustomPasswordTextField> createState() => _CustomPasswordTextFieldState();
}

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: TextFormField(
        onTap: widget.onTap,
        cursorColor: context.colorScheme.primary,
        controller: widget.controller,
        obscureText: _obscureText,
        focusNode: widget.focusNode,
        keyboardType: TextInputType.none,
        textInputAction: widget.textInputAction ?? TextInputAction.next,
        validator: (value) {
          return null;
        },
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
            onPressed: _toggle,
          ),
          hintText: widget.hintTxt ?? '',
          contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15),
          isDense: true,
          filled: true,
          fillColor: Colors.white,
          hintStyle: CustomFontStyle.formsTextStyle,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }
}
