import 'package:flutter/material.dart';

@immutable
final class BorderConstants {
  const BorderConstants._();

  /// BLACK border 1 WIDTH
  static Border get borderAllSmall => Border.all(
        color: Colors.black,
        width: 1.0,
      );
}
