import 'package:a_pos_flutter/product/constant/theme_types/theme_types.dart';
import 'package:flutter/material.dart';

class CustomFontStyle {
  const CustomFontStyle._();

  /// poppins button's text style
  static const buttonTextStyle = TextStyle(fontFamily: FontTypes.poppins);

  /// montserrat title text style
  static const titlesTextStyle = TextStyle(fontFamily: FontTypes.montserrat);

  /// montserrat title bold text style (tertiary color)
  static const titleBoldTertiaryStyle = TextStyle(
    fontFamily: FontTypes.montserrat,
    fontWeight: FontWeight.bold,
    color: Color(0xFF9370db),
  );

  /// montserrat title lineThrough text style
  static const titleErrorTextStyle = TextStyle(
      fontFamily: FontTypes.montserrat,
      color: Color(0xff7a0000),
      decoration: TextDecoration.lineThrough,
      decorationThickness: 3.0);

  /// general roboto  text style
  static const generalTextStyle =
      TextStyle(fontFamily: FontTypes.roboto, fontWeight: FontWeight.normal);

  /// menu Lato text style
  static const menuTextStyle = TextStyle(fontFamily: FontTypes.lato);

  /// forms open-sans text style
  static const formsTextStyle = TextStyle(fontFamily: FontTypes.open_sans);

  /// popupNotification  roboto bold text style
  static const popupNotificationTextStyle =
      TextStyle(fontFamily: FontTypes.roboto, fontWeight: FontWeight.bold);
}
