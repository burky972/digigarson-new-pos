import 'package:a_pos_flutter/language/locale_keys.g.dart';
import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:flutter/material.dart';

/// Keyboard with 1...9 and clear button
class CustomNumberKeyboard extends StatelessWidget {
  const CustomNumberKeyboard({
    super.key,
    required this.onKeyPressed,
    this.width = 270,
    this.height = 290.0,
    this.isOnClose = true,
    required this.onClose,
  });
  final Function(String)? onKeyPressed;
  final double? width;
  final double? height;
  final bool isOnClose;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: const EdgeInsets.all(4),
      width: width ?? 270,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Visibility(
            visible: isOnClose,
            child: Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                    onPressed: onClose,
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomKeyButton('1', onPressed: onKeyPressed),
              CustomKeyButton('2', onPressed: onKeyPressed),
              CustomKeyButton('3', onPressed: onKeyPressed),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomKeyButton('4', onPressed: onKeyPressed),
              CustomKeyButton('5', onPressed: onKeyPressed),
              CustomKeyButton('6', onPressed: onKeyPressed),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomKeyButton('7', onPressed: onKeyPressed),
              CustomKeyButton('8', onPressed: onKeyPressed),
              CustomKeyButton('9', onPressed: onKeyPressed),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomKeyButton(LocaleKeys.clear,
                  onPressed: onKeyPressed, color: context.colorScheme.tertiary),
              CustomKeyButton('0', onPressed: onKeyPressed),
              CustomKeyButton('C',
                  textColor: context.colorScheme.surface,
                  onPressed: onKeyPressed,
                  color: context.colorScheme.tertiary),
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
  final Color textColor;

  const CustomKeyButton(this.label,
      {super.key, this.onPressed, this.color, this.textColor = Colors.blue});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          if (label == LocaleKeys.clear) {
            onPressed?.call("clear");
          } else if (label == "C") {
            onPressed?.call("allClear");
          } else {
            onPressed?.call(label);
          }
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Colors.white,
            fixedSize: const Size(65, 65),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            )),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: label == LocaleKeys.clear
              ? const Center(
                  child: Icon(
                    Icons.backspace_outlined,
                    color: Colors.white,
                  ),
                )
              : Text(
                  label,
                  style: CustomFontStyle.buttonTextStyle
                      .copyWith(color: textColor, fontSize: 16, fontWeight: FontWeight.w600),
                ),
        ));
  }
}
