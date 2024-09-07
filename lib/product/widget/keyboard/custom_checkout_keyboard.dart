import 'package:a_pos_flutter/language/locale_keys.g.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomCheckoutKeyboard extends StatelessWidget {
  const CustomCheckoutKeyboard(
      {super.key, required this.onKeyPressed, required this.onClearPressed});

  final Function(String)? onKeyPressed;
  final Function(String)? onClearPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 300.0,
        width: context.dynamicWidth(.33),
        constraints:
            const BoxConstraints(minHeight: 200, maxHeight: 310, maxWidth: 350, minWidth: 320),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomKeyButton('1', onPressed: onKeyPressed),
                    CustomKeyButton('2', onPressed: onKeyPressed),
                    CustomKeyButton('3', onPressed: onKeyPressed),
                    CustomRightButton(LocaleKeys.reset.tr(), onPressed: onClearPressed)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomKeyButton('4', onPressed: onKeyPressed),
                    CustomKeyButton('5', onPressed: onKeyPressed),
                    CustomKeyButton('6', onPressed: onKeyPressed),
                    CustomRightButton(LocaleKeys.serve.tr())
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomKeyButton('7', onPressed: onKeyPressed),
                    CustomKeyButton('8', onPressed: onKeyPressed),
                    CustomKeyButton('9', onPressed: onKeyPressed),
                    CustomRightButton(LocaleKeys.all.tr())
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomKeyButton("00", onPressed: onKeyPressed),
                    CustomKeyButton('0', onPressed: onKeyPressed),
                    CustomKeyButton(',', onPressed: onKeyPressed),
                    CustomRightButton(LocaleKeys.division.tr())
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomLeftButton(LocaleKeys.discount.tr()),
                    CustomRightButton(LocaleKeys.print.tr())
                  ],
                ),
              ],
            ),
          ],
        ),
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
    return Padding(
      padding: const EdgeInsets.only(left: 1.0, right: 1.0),
      child: ElevatedButton(
        onPressed: () {
          if (label == LocaleKeys.clear.tr()) {
            onPressed?.call("clear");
          } else {
            onPressed?.call(label);
          }
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Colors.red,
            fixedSize: const Size(65, 55),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            )),
        child: Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class CustomRightButton extends StatelessWidget {
  final String label;
  final void Function(String)? onPressed;
  final Color? color;

  const CustomRightButton(this.label, {super.key, this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 3.0, right: 3.0),
      child: ElevatedButton(
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
            fixedSize: const Size(100, 55),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            )),
        child: Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class CustomLeftButton extends StatelessWidget {
  final String label;
  final void Function(String)? onPressed;
  final Color? color;

  const CustomLeftButton(this.label, {super.key, this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 3.0, right: 3.0),
      child: ElevatedButton(
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
            fixedSize: const Size(195, 55),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            )),
        child: Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
