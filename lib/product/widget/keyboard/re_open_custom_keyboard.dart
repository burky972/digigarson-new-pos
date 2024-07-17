import 'package:a_pos_flutter/language/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ReOpenCustomKeyboard extends StatelessWidget {
  final Function(String)? onKeyPressed;
  double? width;

  ReOpenCustomKeyboard({super.key, required this.onKeyPressed, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 250.0,
      width: width ?? 270,
      constraints: const BoxConstraints(minHeight: 200, maxHeight: 465),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 210,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
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
                    CustomKeyButton(LocaleKeys.clear.tr(),
                        onPressed: onKeyPressed, color: Colors.red.shade200),
                    CustomKeyButton('0', onPressed: onKeyPressed),
                    CustomKeyButton(
                      '.',
                      onPressed: onKeyPressed,
                    ),
                  ],
                ),
              ],
            ),
          ),
          CustomCloseButton(LocaleKeys.close.tr(), onPressed: onKeyPressed),
        ],
      ),
    );
  }
}

class CustomKeyButton extends StatelessWidget {
  final String label;
  final void Function(String)? onPressed;
  final Color? color;

  const CustomKeyButton(this.label, {super.key, this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (label == LocaleKeys.clear.tr()) {
          onPressed?.call("clear");
        } else {
          onPressed?.call(label);
        }
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: color ?? Colors.blueAccent,
          fixedSize: const Size(55, 55),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          )),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

class CustomCloseButton extends StatelessWidget {
  final String label;
  final void Function(String)? onPressed;
  final Color? color;

  const CustomCloseButton(this.label, {super.key, this.onPressed, this.color});

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
          backgroundColor: Colors.red,
          fixedSize: const Size(10, 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          )),
      child: const Icon(
        Icons.close,
        size: 17,
        color: Colors.white,
      ),
    );
  }
}
