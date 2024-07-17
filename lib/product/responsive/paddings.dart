import 'package:flutter/material.dart';

@immutable
final class AppPadding extends EdgeInsets {
  const AppPadding() : super.all(0);

  /// [AppPadding.extraMinAll] is 4
  const AppPadding.extraMinAll() : super.all(4);

  /// [AppPadding.minAll] is 8
  const AppPadding.minAll() : super.all(8);

  /// [ProjectPadding.normalAll] is 16

  const AppPadding.normalAll() : super.all(16);

  /// [ProjectPadding.largeAll] is 20

  const AppPadding.largeAll() : super.all(20);

  /// [ProjectPadding.xLargeAll] is 24

  const AppPadding.xLargeAll() : super.all(24);

  /// [ProjectPadding.lowHorizontal] is 8

  const AppPadding.lowHorizontal() : super.symmetric(horizontal: 8);

  /// [ProjectPadding.extraLowVertical] is 4

  const AppPadding.extraLowVertical() : super.symmetric(vertical: 4);

  /// [ProjectPadding.lowVertical] is 8

  const AppPadding.lowVertical() : super.symmetric(vertical: 8);

  /// [ProjectPadding.normalVertical] is 16

  const AppPadding.normalVertical() : super.symmetric(vertical: 16);

  /// [ProjectPadding.normalVertical] is 16

  const AppPadding.normalHorizontal() : super.symmetric(horizontal: 16);

  /// [ProjectPadding.normalSymmetricHorVer] is 12

  const AppPadding.normalSymmetricHorVer() : super.symmetric(vertical: 12, horizontal: 12);

  /// [ProjectPadding.lowSymmetricHorVer] is 12

  const AppPadding.lowSymmetricHorVer() : super.symmetric(horizontal: 4, vertical: 4);
}
