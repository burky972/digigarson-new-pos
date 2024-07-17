import 'package:a_pos_flutter/product/constant/theme_types/theme_types.dart';
import 'package:flutter/material.dart';

final class CustomFontStyle {
  const CustomFontStyle._();

  /// poppins button's text style
  static const buttonTextStyle = TextStyle(fontFamily: FontTypes.poppins);

  /// montserrat title text style
  static const titlesTextStyle = TextStyle(fontFamily: FontTypes.montserrat);

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