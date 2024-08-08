// ignore_for_file: non_constant_identifier_names, deprecated_member_use

import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:flutter/material.dart';

///orange
const _primaryColor = Color(0xffff6347);

///black
const _secondaryColor = Color(0xff1A1A1A);

/// purple
const _tertiaryColor = Color(0xFF9370db);

/// grey color
const _surfaceTint = Color(0xffd3d3d3);

///wthite
const _surfaceColor = Color(0xffffffff);
const _onSecondary = Color(0xffadd8e5);
const _surfaceVariant = Color(0x21444444);
const _onSurfaceColor = Color(0xff000000);
const _textColor = Color(0xff1A1A1A);

const _colorScheme = ColorScheme(
  primary: _primaryColor,
  secondary: _secondaryColor,
  tertiary: _tertiaryColor,
  onTertiary: _onSurfaceColor,
  surfaceTint: _surfaceTint,
  surface: _surfaceColor,
  surfaceVariant: _surfaceVariant,
  background: _surfaceColor,
  error: Color.fromARGB(255, 255, 0, 0),
  errorContainer: Color(0XFFe78b8b),
  onPrimary: _surfaceColor,
  onSecondary: _onSecondary,
  onSurface: _onSurfaceColor,
  onBackground: _surfaceColor,
  onError: _surfaceColor,
  brightness: Brightness.light,
);

final ThemeData APosTheme = ThemeData(
  useMaterial3: false,
  brightness: Brightness.light,
  primaryColor: _primaryColor,
  primaryColorLight: _primaryColor.withOpacity(0.1),
  primaryColorDark: Colors.black,
  scaffoldBackgroundColor: const Color(0xfffafafa),
  cardColor: const Color(0xffffffff),
  dividerColor: const Color.fromARGB(255, 0, 0, 0),
  highlightColor: const Color(0x66bcbcbc),
  splashColor: const Color(0x66c8c8c8),
  unselectedWidgetColor: const Color(0xffffffff),
  disabledColor: const Color(0xffF4F4F4),
  secondaryHeaderColor: const Color(0xfffbe9ec), // beyaz
  dialogBackgroundColor: const Color(0xffffffff),
  indicatorColor: _primaryColor,
  hintColor: const Color(0x8a000000),
  buttonTheme: const ButtonThemeData(
    textTheme: ButtonTextTheme.normal,
    minWidth: 88,
    height: 36,
    shape: RoundedRectangleBorder(
      side: BorderSide(
        color: Color(0xff1A1A1A),
        width: 0,
        style: BorderStyle.none,
      ),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    alignedDropdown: false,
    buttonColor: _primaryColor,
    disabledColor: Color(0x61000000),
    highlightColor: Color(0x29000000),
    splashColor: Color(0x1f000000),
    focusColor: Color(0x1f000000),
    hoverColor: Color(0x0a000000),
    colorScheme: _colorScheme,
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      color: Color(0xff1A1A1A),
      fontSize: null,
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal,
    ),
    displayMedium: TextStyle(
      color: _textColor,
      fontSize: null,
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal,
    ),
    displaySmall: TextStyle(
      color: _textColor,
      fontSize: 48.0,
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal,
    ),
    headlineLarge: TextStyle(
      color: _textColor,
      fontSize: 32,
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal,
    ),
    headlineMedium: TextStyle(
      color: _textColor,
      fontSize: 28,
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
    ),
    headlineSmall: TextStyle(
      color: _textColor, // başlık rengi
      fontSize: 24.0,
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
    ),
    titleLarge: TextStyle(
      color: _textColor,
      fontSize: 20.0,
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal,
    ),
    titleMedium: TextStyle(
      color: _textColor,
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
    ),
    titleSmall: TextStyle(
      color: _textColor,
      fontSize: 14.0,
      fontStyle: FontStyle.normal,
    ),
    bodyLarge: CustomFontStyle.generalTextStyle,
    bodyMedium: TextStyle(
      color: _textColor,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    bodySmall: TextStyle(
      color: _textColor,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
  ),

  // inputDecorationTheme: const InputDecorationTheme(
  //   labelStyle: CustomFontStyle.formsTextStyle,
  //   helperStyle: TextStyle(
  //     color: Color(0xdd000000),
  //     fontSize: null,
  //     fontWeight: FontWeight.w400,
  //     fontStyle: FontStyle.normal,
  //   ),
  //   hintStyle: TextStyle(
  //     color: Color(0xdd000000),
  //     fontSize: null,
  //     fontWeight: FontWeight.w400,
  //     fontStyle: FontStyle.normal,
  //   ),
  //   errorStyle: TextStyle(
  //     color: Color(0xdd000000),
  //     fontSize: null,
  //     fontWeight: FontWeight.w400,
  //     fontStyle: FontStyle.normal,
  //   ),
  //   errorMaxLines: null,
  //   isDense: false,
  //   contentPadding: EdgeInsets.only(top: 12, bottom: 12, left: 0, right: 0),
  //   isCollapsed: false,
  //   prefixStyle: TextStyle(
  //     color: Color(0xdd000000),
  //     fontSize: null,
  //     fontWeight: FontWeight.w400,
  //     fontStyle: FontStyle.normal,
  //   ),
  //   suffixStyle: TextStyle(
  //     color: Color(0xdd000000),
  //     fontSize: null,
  //     fontWeight: FontWeight.w400,
  //     fontStyle: FontStyle.normal,
  //   ),
  //   counterStyle: TextStyle(
  //     color: Color(0xdd000000),
  //     fontSize: null,
  //     fontWeight: FontWeight.w400,
  //     fontStyle: FontStyle.normal,
  //   ),
  //   filled: false,
  //   fillColor: Color(0x00000000),
  //   floatingLabelBehavior: FloatingLabelBehavior.auto,
  //   errorBorder: UnderlineInputBorder(
  //     borderSide: BorderSide(
  //       color: Color(0xff000000),
  //       width: 1,
  //       style: BorderStyle.solid,
  //     ),
  //     borderRadius: BorderRadius.all(Radius.circular(4.0)),
  //   ),
  //   focusedBorder: UnderlineInputBorder(
  //     borderSide: BorderSide(
  //       color: Color(0xff000000),
  //       width: 1,
  //       style: BorderStyle.solid,
  //     ),
  //     borderRadius: BorderRadius.all(Radius.circular(4.0)),
  //   ),
  //   focusedErrorBorder: UnderlineInputBorder(
  //     borderSide: BorderSide(
  //       color: Color(0xff000000),
  //       width: 1,
  //       style: BorderStyle.solid,
  //     ),
  //     borderRadius: BorderRadius.all(Radius.circular(4.0)),
  //   ),
  //   disabledBorder: UnderlineInputBorder(
  //     borderSide: BorderSide(
  //       color: Color(0xff000000),
  //       width: 1,
  //       style: BorderStyle.solid,
  //     ),
  //     borderRadius: BorderRadius.all(Radius.circular(4.0)),
  //   ),
  //   enabledBorder: UnderlineInputBorder(
  //     borderSide: BorderSide(
  //       color: Color(0xff000000),
  //       width: 1,
  //       style: BorderStyle.solid,
  //     ),
  //     borderRadius: BorderRadius.all(Radius.circular(4.0)),
  //   ),
  //   border: UnderlineInputBorder(
  //     borderSide: BorderSide(
  //       color: Color(0xff000000),
  //       width: 1,
  //       style: BorderStyle.solid,
  //     ),
  //     borderRadius: BorderRadius.all(Radius.circular(4.0)),
  //   ),
  // ),

  iconTheme: const IconThemeData(
    color: Color(0xdd000000),
    opacity: 1,
    size: 24,
  ),
  primaryIconTheme: const IconThemeData(
    color: Color(0xffffffff),
    opacity: 1,
    size: 24,
  ),
  sliderTheme: const SliderThemeData(
    activeTrackColor: Colors.white,
    inactiveTrackColor: Colors.white,
    disabledActiveTrackColor: null,
    disabledInactiveTrackColor: null,
    activeTickMarkColor: null,
    inactiveTickMarkColor: null,
    disabledActiveTickMarkColor: null,
    disabledInactiveTickMarkColor: null,
    thumbColor: null,
    disabledThumbColor: null,
    thumbShape: null,
    overlayColor: null,
    valueIndicatorColor: null,
    valueIndicatorShape: null,
    showValueIndicator: null,
    valueIndicatorTextStyle: TextStyle(
      color: Color(0xffffffff),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
  ),
  tabBarTheme: const TabBarTheme(
    indicatorSize: TabBarIndicatorSize.tab,
    labelColor: Color(0xffffffff),
    unselectedLabelColor: Color(0xb2ffffff),
  ),
  chipTheme: const ChipThemeData(
    backgroundColor: Color(0x1f000000),
    brightness: Brightness.light,
    deleteIconColor: Color(0xde000000),
    disabledColor: Color(0x0c000000),
    labelPadding: EdgeInsets.only(top: 0, bottom: 0, left: 8, right: 8),
    labelStyle: TextStyle(
      color: Color(0xde000000),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    padding: EdgeInsets.only(top: 4, bottom: 4, left: 4, right: 4),
    secondaryLabelStyle: TextStyle(
      color: Color(0x3d000000),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    secondarySelectedColor: Color(0x3d971b2e),
    selectedColor: Color(0x3d000000),
    shape: StadiumBorder(
        side: BorderSide(
      color: Color(0xff000000),
      width: 0,
      style: BorderStyle.none,
    )),
  ),
  dialogTheme: const DialogTheme(
      shape: RoundedRectangleBorder(
    side: BorderSide(
      color: Color(0xff000000),
      width: 0,
      style: BorderStyle.none,
    ),
    borderRadius: BorderRadius.all(Radius.circular(0.0)),
  )),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Color(0xff4285f4),
    selectionColor: Color(0xfff0a8b3),
    selectionHandleColor: Color(0xffe87d8e),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    centerTitle: true,
    foregroundColor: _textColor,
    elevation: 0,
  ),
  checkboxTheme: const CheckboxThemeData(
      fillColor: WidgetStatePropertyAll(_surfaceColor),
      checkColor: WidgetStatePropertyAll(_primaryColor),
      side: BorderSide(color: _secondaryColor)),
  radioTheme: RadioThemeData(
    fillColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return null;
      }
      if (states.contains(MaterialState.selected)) {
        return _primaryColor;
      }
      return null;
    }),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return null;
      }
      if (states.contains(MaterialState.selected)) {
        return _primaryColor;
      }
      return null;
    }),
    trackColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return null;
      }
      if (states.contains(MaterialState.selected)) {
        return _primaryColor;
      }
      return null;
    }),
  ),
  colorScheme: _colorScheme.copyWith(error: _primaryColor),
  bottomAppBarTheme: const BottomAppBarTheme(color: _primaryColor),
);
