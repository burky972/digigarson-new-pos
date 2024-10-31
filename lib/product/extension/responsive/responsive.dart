import 'package:flutter/material.dart';

extension ResponsiveExtension on BuildContext {
  double get height => MediaQuery.sizeOf(this).height;
  double get width => MediaQuery.sizeOf(this).width;
  double dynamicHeight(double value) => height * value;
  double dynamicWidth(double value) => width * value;
}
