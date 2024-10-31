import 'dart:async';

import 'package:a_pos_flutter/language/locale_keys.g.dart';
import 'package:a_pos_flutter/product/global/getters/getter.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:a_pos_flutter/product/widget/button/light_blue_button.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

showOrderWarningDialog(BuildContext context, String title, {bool? secondClose}) {
  AwesomeDialog(
    dismissOnTouchOutside: false,
    width: 550,
    context: context,
    animType: AnimType.leftSlide,
    headerAnimationLoop: false,
    dialogType: DialogType.warning,
    showCloseIcon: false,
    title: title,
  ).show();
  Timer(const Duration(milliseconds: 1200), () {
    routeManager.pop();

    secondClose != null ? routeManager.pop() : null;
  });
}

showOrderSuccessDialog(String title, {bool? secondClose}) {
  AwesomeDialog(
    dismissOnTouchOutside: false,
    width: 550,
    context: routeContext,
    animType: AnimType.leftSlide,
    headerAnimationLoop: false,
    dialogType: DialogType.success,
    showCloseIcon: false,
    title: title,
  ).show();
  Timer(const Duration(milliseconds: 1500), () {
    routeManager.pop();

    secondClose != null ? routeManager.pop() : null;
  });
}

showOrderErrorDialog(String title, {bool? secondClose}) {
  AwesomeDialog(
    dismissOnTouchOutside: false,
    width: 550,
    context: routeContext,
    animType: AnimType.leftSlide,
    headerAnimationLoop: false,
    dialogType: DialogType.error,
    showCloseIcon: false,
    title: title,
  ).show();
  Timer(const Duration(milliseconds: 1500), () {
    routeManager.pop();
    secondClose != null ? routeManager.pop() : null;
  });
}

//! pop op without closing depends on the duration- only ok button on center bottom
showOrderDialogWithOutCustomDuration(BuildContext context, String title,
    {DialogType? type, void Function()? onPressed}) {
  AwesomeDialog(
    btnOk: TextButton(
        onPressed: () => onPressed != null ? onPressed() : routeManager.pop(),
        child: const Text('Ok')),
    width: 550,
    context: context,
    animType: AnimType.leftSlide,
    headerAnimationLoop: false,
    dialogType: type ?? DialogType.error,
    showCloseIcon: false,
    title: title,
  ).show();
}

//! pop op without closing depends on the duration- only ok,Cancel button on center bottom
showOrderDialogWithOutCustomDurationOkCancel(BuildContext context, String title,
    {required void Function()? onCancelPressed, onOkPressed}) {
  AwesomeDialog(
    dismissOnTouchOutside: false,
    btnOk: TextButton(onPressed: onCancelPressed, child: const Text('Cancel')),
    btnCancel: TextButton(
      onPressed: onOkPressed,
      style: const ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          Color(0xFF7DB6F5),
        ),
      ),
      child: const Text('Ok'),
    ),
    width: 550,
    context: context,
    animType: AnimType.leftSlide,
    headerAnimationLoop: false,
    dialogType: DialogType.question,
    showCloseIcon: false,
    title: title,
  ).show();
}

showOrderErrorNotProductDialog(BuildContext context, String title, {bool? secondClose}) {
  AwesomeDialog(
    dismissOnTouchOutside: false,
    width: 550,
    context: context,
    animType: AnimType.leftSlide,
    headerAnimationLoop: false,
    dialogType: DialogType.error,
    showCloseIcon: false,
    title: title,
  ).show();
  Timer(const Duration(milliseconds: 1500), () {
    routeManager.pop();
    secondClose != null ? routeManager.pop() : null;
  });
}

// //!
showOrderSuccessPriceChangedDialog(BuildContext context, String title,
    {bool? secondClose, required void Function()? onNavigate}) {
  AwesomeDialog(
    dismissOnTouchOutside: false,
    width: 550,
    context: context,
    animType: AnimType.leftSlide,
    headerAnimationLoop: false,
    dialogType: DialogType.success,
    showCloseIcon: false,
    title: title,
  ).show();
  Timer(const Duration(milliseconds: 1500), () {
    routeManager.pop();
    if (secondClose != null && secondClose) {
      if (onNavigate != null) {
        onNavigate();
      }
    }
  });
}

///SHOW ERROR DIALOG
showErrorDialog(String title, {bool? secondClose}) {
  AwesomeDialog(
    dismissOnTouchOutside: false,
    width: 550,
    context: routeContext,
    animType: AnimType.leftSlide,
    headerAnimationLoop: false,
    dialogType: DialogType.error,
    showCloseIcon: false,
    title: title,
  ).show();
  Timer(const Duration(milliseconds: 1500), () {
    routeManager.pop();

    secondClose != null ? routeManager.pop() : null;
  });
}

//! pop op without closing depends on the duration- only ok,Cancel button on center bottom
showCloseTableDialog(BuildContext context, {required void Function()? onOkPressed}) {
  AwesomeDialog(
    dismissOnTouchOutside: false,
    btnOk: LightBlueButton(onTap: () => routeManager.pop(), buttonText: 'Cancel'),
    btnCancel: LightBlueButton(buttonText: 'Ok', onTap: onOkPressed),
    width: 550,
    context: context,
    animType: AnimType.leftSlide,
    headerAnimationLoop: false,
    dialogType: DialogType.question,
    showCloseIcon: false,
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            LocaleKeys.sureCleanTable.tr(),
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headlineLarge
                ?.copyWith(color: const Color(0xff616161), fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          Text(
            LocaleKeys.sureCleanTableContent,
            style: CustomFontStyle.titlesTextStyle
                .copyWith(fontSize: 18, color: const Color(0xff616161)),
          ).tr(),
          const SizedBox(height: 12),
        ],
      ),
    ),
  ).show();
}
