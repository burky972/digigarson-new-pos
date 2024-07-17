// ignore_for_file: constant_identifier_names

import 'package:a_pos_flutter/gen/assets.gen.dart';
import 'package:flutter/material.dart';

enum ETableTypes {
  TABLE_FOR_ONE_UP(1),
  TABLE_FOR_ONE_DOWN(2),
  TABLE_FOR_ONE_RIGHT(3),
  TABLE_FOR_ONE_LEFT(4),
  ROUND_TABLE_FOR_TWO_HORIZONTAL(5),
  ROUND_TABLE_FOR_TWO_VERTICAL(6),
  ROUND_TABLE_FOR_FOUR(7),
  ROUND_TABLE_FOR_SIX(8),
  RECTANGULAR_TABLE_FOR_TWO_HORIZONTAL(9),
  RECTANGULAR_TABLE_FOR_TWO_VERTICAL(10),
  RECTANGULAR_TABLE_FOR_FOUR_VERTICAL(11),
  RECTANGULAR_TABLE_FOR_FOUR_HORIZONTAL(12),
  RECTANGULAR_TABLE_FOR_SIX_VERTICAL(13),
  RECTANGULAR_TABLE_FOR_SIX_HORIZONTAL(14),
  SQUARE_TABLE_FOR_FOUR(15),
  SQUARE_TABLE_FOR_FOUR_DIAGONAL(16);

  const ETableTypes(this.value);
  final int value;
  static ETableTypes fromValue(int value) {
    return ETableTypes.values.firstWhere(
      (e) => e.value == value,
    );
  }
}

Widget getTableType(int type) {
  switch (type) {
    case 1:
      return Assets.images.tables.a1.image();
    case 2:
      return Assets.images.tables.a2.image();
    case 3:
      return Assets.images.tables.a3.image();
    case 4:
      return Assets.images.tables.a4.image();
    case 5:
      return Assets.images.tables.a5.image();
    case 6:
      return Assets.images.tables.a6.image();
    case 7:
      return Assets.images.tables.a7.image();
    case 8:
      return Assets.images.tables.a8.image();
    case 9:
      return Assets.images.tables.a9.image();
    case 10:
      return Assets.images.tables.a10.image();
    case 11:
      return Assets.images.tables.a11.image();
    case 12:
      return Assets.images.tables.a12.image();
    case 13:
      return Assets.images.tables.a13.image();
    case 14:
      return Assets.images.tables.a14.image();
    case 15:
      return Assets.images.tables.a15.image();
    case 16:
      return Assets.images.tables.a16.image();
    default:
      return const Icon(Icons.help); // default icon.
  }
}
