import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
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
    Navigator.of(context).pop();
    secondClose != null ? Navigator.of(context).pop() : null;
  });
}

showOrderSuccessDialog(BuildContext context, String title, {bool? secondClose}) {
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
    Navigator.of(context).pop();
    secondClose != null ? Navigator.of(context).pop() : null;
  });
}

showOrderErrorDialog(BuildContext context, String title, {bool? secondClose}) {
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
    Navigator.of(context).pop();
    secondClose != null ? Navigator.of(context).pop() : null;
  });
}

//! pop op without closing depends on the duration- only ok button on center bottom
showOrderDialogWithOutCustomDuration(BuildContext context, String title, {DialogType? type}) {
  AwesomeDialog(
    btnOk: TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Ok')),
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
    Navigator.of(context).pop();
    secondClose != null ? Navigator.of(context).pop() : null;
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
    Navigator.of(context).pop();
    if (secondClose != null && secondClose) {
      if (onNavigate != null) {
        onNavigate();
      }
    }
  });
}

///SHOW ERROR DIALOG
showErrorDialog(BuildContext context, String title, {bool? secondClose}) {
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
    Navigator.of(context).pop();
    secondClose != null ? Navigator.of(context).pop() : null;
  });
}

//! pop op without closing depends on the duration- only ok,Cancel button on center bottom
showCloseTableDialog(BuildContext context, {required void Function()? onOkPressed}) {
  AwesomeDialog(
    // dismissOnTouchOutside: false,
    btnOk: TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
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
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Masayı sıfırlamak istediğinize emin misiniz?',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headlineLarge
                ?.copyWith(color: const Color(0xff616161), fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
                text: 'Masada kayıtlı olan bilgiler kaybolacaktır. ',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: const Color(0xff616161)),
                children: [
                  TextSpan(
                      text: 'Bu işlem sonunda adisyon kaydedilmeyecektir. ',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold, color: const Color(0xff616161))),
                  TextSpan(
                      text:
                          'Adisyonun kaydedilmesini istiyorsanız siparişi tamamla butonuna tıklayınız!',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: const Color(0xff616161))),
                ]),
          ),
          const SizedBox(height: 12),
        ],
      ),
    ),
  ).show();
}
