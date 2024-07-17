import 'package:a_pos_flutter/language/locale_keys.g.dart';
import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomSearchKeyboard extends StatelessWidget {
  final Function(String)? onKeyPressed;
  double? width;

  CustomSearchKeyboard({super.key, required this.onKeyPressed, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white70.withOpacity(0.9),
      height: 290.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomKeyButton('0', onPressed: onKeyPressed),
              CustomKeyButton('1', onPressed: onKeyPressed),
              CustomKeyButton('2', onPressed: onKeyPressed),
              CustomKeyButton('3', onPressed: onKeyPressed),
              CustomKeyButton('4', onPressed: onKeyPressed),
              CustomKeyButton('5', onPressed: onKeyPressed),
              CustomKeyButton('6', onPressed: onKeyPressed),
              CustomKeyButton('7', onPressed: onKeyPressed),
              CustomKeyButton('8', onPressed: onKeyPressed),
              CustomKeyButton('9', onPressed: onKeyPressed),
              CustomKeyButton('-', onPressed: onKeyPressed),
              CustomKeyButton(
                LocaleKeys.close.tr(),
                onPressed: onKeyPressed,
                color: Colors.red,
                icon: Icons.cancel,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomKeyButton('Q', onPressed: onKeyPressed),
              CustomKeyButton('W', onPressed: onKeyPressed),
              CustomKeyButton('E', onPressed: onKeyPressed),
              CustomKeyButton('R', onPressed: onKeyPressed),
              CustomKeyButton('T', onPressed: onKeyPressed),
              CustomKeyButton('Y', onPressed: onKeyPressed),
              CustomKeyButton('U', onPressed: onKeyPressed),
              CustomKeyButton('I', onPressed: onKeyPressed),
              CustomKeyButton('O', onPressed: onKeyPressed),
              CustomKeyButton('P', onPressed: onKeyPressed),
              CustomKeyButton('Ğ', onPressed: onKeyPressed),
              CustomKeyButton('Ü', onPressed: onKeyPressed),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomKeyButton('A', onPressed: onKeyPressed),
              CustomKeyButton('S', onPressed: onKeyPressed),
              CustomKeyButton('D', onPressed: onKeyPressed),
              CustomKeyButton('F', onPressed: onKeyPressed),
              CustomKeyButton('G', onPressed: onKeyPressed),
              CustomKeyButton('H', onPressed: onKeyPressed),
              CustomKeyButton('J', onPressed: onKeyPressed),
              CustomKeyButton('K', onPressed: onKeyPressed),
              CustomKeyButton('L', onPressed: onKeyPressed),
              CustomKeyButton('Ş', onPressed: onKeyPressed),
              CustomKeyButton('İ', onPressed: onKeyPressed),
              CustomKeyButton(LocaleKeys.clear.tr(),
                  onPressed: onKeyPressed, icon: Icons.backspace_outlined),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomKeyButton('Z', onPressed: onKeyPressed),
              CustomKeyButton('X', onPressed: onKeyPressed),
              CustomKeyButton('C', onPressed: onKeyPressed),
              CustomKeyButton('V', onPressed: onKeyPressed),
              CustomKeyButton('B', onPressed: onKeyPressed),
              CustomKeyButton('N', onPressed: onKeyPressed),
              CustomKeyButton('M', onPressed: onKeyPressed),
              CustomKeyButton('Ö', onPressed: onKeyPressed),
              CustomKeyButton('Ç', onPressed: onKeyPressed),
              CustomKeyButton(',', onPressed: onKeyPressed),
              CustomKeyButton('.', onPressed: onKeyPressed),
              CustomKeyButton(' ', onPressed: onKeyPressed, icon: Icons.space_bar),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomKeyButton extends StatelessWidget {
  final String label;
  final void Function(String)? onPressed;
  final Color? color;
  final IconData? icon;

  const CustomKeyButton(this.label, {super.key, this.onPressed, this.color, this.icon});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (label == LocaleKeys.clear.tr()) {
          onPressed?.call("clear");
        } else if (label == LocaleKeys.close.tr()) {
          onPressed?.call("close");
        } else {
          onPressed?.call(label);
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? context.colorScheme.tertiary,
        fixedSize: const Size(70, 70),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: icon != null
            ? Icon(
                icon!,
                size: 19,
                color: context.colorScheme.surface,
              )
            : Text(
                label,
                style: CustomFontStyle.generalTextStyle,
              ),
      ),
    );
  }
}
